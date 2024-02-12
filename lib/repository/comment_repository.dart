import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:twenty_four/api/comments_api.dart';

import '../domain/comment.dart';

@injectable
class CommentRepository {
  final CommentsApi commentsApi;

  CommentRepository(this.commentsApi);

  Future<void> addComment(String postId, String userId, String content) {
    final comment = Comment(
      postId: postId,
      userId: userId,
      content: content,
      date: DateTime.now(),
      userName: FirebaseAuth.instance.currentUser!.displayName!.isNotEmpty
          ? FirebaseAuth.instance.currentUser!.displayName!
          : FirebaseAuth.instance.currentUser!.email!.split('@').first,
    );
    return commentsApi.addComment(comment);
  }

  Future<List<Comment>> getCommentsByPostId(String postId) async {
    return await commentsApi.getCommentsByPostId(postId);
  }

}