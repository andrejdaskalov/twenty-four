import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../api/likes_api.dart';
import '../api/media_api.dart';
import '../api/post_api.dart';
import '../api/topic_api.dart';
import '../domain/like_model.dart';
import '../domain/post.dart';
import '../service/location_service.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';


@injectable
class PostRepository {
  final PostApi _postApi;
  final MediaApi _mediaApi;
  final TopicApi _topicApi;
  final LikesApi _likesApi;
  final LocationService _locationService;

  PostRepository(this._postApi, this._mediaApi, this._topicApi, this._likesApi, this._locationService);

  Future<List<Post>> getPostsByTopicId(String topicId) async {
    var posts = await _postApi.getPostsByTopicId(topicId);
    final user = FirebaseAuth.instance.currentUser?.uid;
    for (var post in posts) {
      var downloadUrls = await Future.wait(post.mediaURIs.map((uri) async {
        return await _mediaApi.getDownloadURL(uri);
      }));
      post.mediaURIs = downloadUrls;
      post.likedByUser = await _likesApi.userHasLiked(post.id!, user ?? '');
    }
    return posts;
  }

  Future<String> getDownloadURL(String path) async {
    return await _mediaApi.getDownloadURL(path);
  }

  Future<void> addPost(String title, String description, String imagePath) async {
    final currentUser = FirebaseAuth.instance.currentUser?.uid;
    await _compressImage(imagePath);
    final imageURI = await _mediaApi.uploadImage(imagePath);
    final topic = await _topicApi.getTodayTopic();
    final location = await _locationService.getLocation();
    final userName = FirebaseAuth.instance.currentUser?.displayName != null
        && FirebaseAuth.instance.currentUser!.displayName!.isNotEmpty
        ? FirebaseAuth.instance.currentUser?.displayName
        : FirebaseAuth.instance.currentUser?.email?.split('@').first;
    final post = Post(
      title: title,
      description: description,
      mediaURIs: [imageURI],
      userUID: currentUser ?? '',
      topicId: topic.id,
      date: DateTime.now(),
      likes: 0,
      id: '',
      location: location,
      userName: userName,
    );
    await _postApi.addPost(post);
  }

  Future<void> likePost(String postId) async {
    final currentUser = FirebaseAuth.instance.currentUser?.uid;
    final like = LikeUserModel(
      postId: postId,
      userUID: currentUser ?? '',
    );
    await _likesApi.addLike(like);
    await _postApi.likePost(postId);
  }

  Future<void> unlikePost(String postId) async {
    final currentUser = FirebaseAuth.instance.currentUser?.uid;
    await _likesApi.removeLike(postId, currentUser ?? '');
    await _postApi.unlikePost(postId);
  }

  Future<void> _compressImage(String path) async {
    await FlutterImageCompress.compressAndGetFile(
      path, path,
      quality: 88,
    );
  }

}
