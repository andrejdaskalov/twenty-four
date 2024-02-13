import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../api/likes_api.dart';
import '../api/media_api.dart';
import '../api/post_api.dart';
import '../api/topic_api.dart';
import '../domain/like_model.dart';
import '../domain/post.dart';
import '../service/location_service.dart';

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
      // var downloadUrls = await Future.wait(post.mediaURIs.map((uri) async {
      //   return await _mediaApi.getDownloadURL(uri);
      // }));
      post.mediaURIs = ["https://picsum.photos/300/200"]; // todo remove this line and uncomment surrounding
      // post.mediaURIs = downloadUrls;
      post.likedByUser = await _likesApi.userHasLiked(post.id!, user ?? '');
    }
    return posts;
  }

  Future<String> getDownloadURL(String path) async {
    return await _mediaApi.getDownloadURL(path);
  }

  Future<void> addPost(String title, String description, String imagePath) async {
    final currentUser = FirebaseAuth.instance.currentUser?.uid;
    final imageURI = await _mediaApi.uploadImage(imagePath);
    final topic = await _topicApi.getTodayTopic();
    final location = await _locationService.getLocation();
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

}
