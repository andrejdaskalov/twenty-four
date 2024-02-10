import 'package:injectable/injectable.dart';
import '../api/media_api.dart';
import '../api/post_api.dart';
import '../domain/post.dart';

@injectable
class PostRepository {
  final PostApi _postApi;
  final MediaApi _mediaApi;

  PostRepository(this._postApi, this._mediaApi);

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
}
