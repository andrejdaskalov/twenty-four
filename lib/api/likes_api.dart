
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:twenty_four/domain/like_model.dart';

@injectable
class LikesApi {

  CollectionReference likes = FirebaseFirestore.instance.collection('likes');

  Future<bool> userHasLiked(String postId, String userUID) async {
    final snapshot = await likes
        .where('postId', isEqualTo: postId)
        .where('userUID', isEqualTo: userUID)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  Future<void> addLike(LikeUserModel like) async {
    await likes.add({
      'postId': like.postId,
      'userUID': like.userUID,
    });
  }

  Future<void> removeLike(String postId, String userUID) async {
    final snapshot = await likes
        .where('postId', isEqualTo: postId)
        .where('userUID', isEqualTo: userUID)
        .get();
    final docs = snapshot.docs;
    if (docs.isEmpty) {
      return;
    }
    await likes.doc(docs.first.id).delete();
  }
}