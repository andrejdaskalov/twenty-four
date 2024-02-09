import 'package:injectable/injectable.dart';
import '../api/post_api.dart';
import '../domain/post.dart';

@injectable
class PostRepository {
  final PostApi _postApi;

  PostRepository(this._postApi);

  Future<List<Post>> getPostsByTopicId(String topicId) async {
    return _postApi.getPostsByTopicId(topicId);
  }
}
