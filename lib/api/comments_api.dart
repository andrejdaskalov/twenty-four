import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:twenty_four/domain/comment.dart';

@injectable
class CommentsApi {

  CollectionReference comments = FirebaseFirestore.instance.collection('comments');

  Future<void> addComment(Comment comment) async {
    await comments.add({
      'postId': comment.postId,
      'userUID': comment.userId,
      'content': comment.content,
      'date': comment.date,
      'userName': comment.userName,
    });
  }

  Future<List<Comment>> getCommentsByPostId(String postId) async {
    final snapshot = await comments
        .where('postId', isEqualTo: postId)
        .orderBy('date', descending: true)
        .get();
    return snapshot.docs.map((doc) {
      return Comment(
        postId: doc['postId'],
        userId: doc['userUID'],
        content: doc['content'],
        date: doc['date'].toDate(),
        userName: doc['userName'],
      );
    }).toList();
  }

}