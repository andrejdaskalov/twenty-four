import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../api/media_api.dart';
import '../api/post_api.dart';
import '../api/topic_api.dart';
import '../domain/post.dart';

@injectable
class PostRepository {
  final PostApi _postApi;
  final MediaApi _mediaApi;
  final TopicApi _topicApi;

  PostRepository(this._postApi, this._mediaApi, this._topicApi);

  Future<List<Post>> getPostsByTopicId(String topicId) async {
    var posts = await _postApi.getPostsByTopicId(topicId);
    for (var post in posts) {
      var downloadUrls = await Future.wait(post.mediaURIs.map((uri) async {
        return await _mediaApi.getDownloadURL(uri);
      }));
      post.mediaURIs = downloadUrls;
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
    final post = Post(
      title: title,
      description: description,
      mediaURIs: [imageURI],
      userUID: currentUser ?? '',
      topicId: topic.id,
      date: DateTime.now(),
      likes: 0,
      id: '',

    );
    await _postApi.addPost(post);
  }
}
