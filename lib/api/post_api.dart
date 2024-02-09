import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../domain/post.dart';

@injectable
class PostApi {
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');
  // TODO: fix needs to return a list of posts
  Future<Post> getPostsByTopicId(String topicId) async {
    final snapshot = await posts
        .where('topicId', isEqualTo: topicId)
        .orderBy('date')
        .get();
    final docs = snapshot.docs;
    if (docs.isEmpty) {
      return Post(
        id: "0",
        topicId: "0",
        title: 'No post for this topic',
        date: DateTime.now(),
        description: '',
        userUID: '',

      );
    }
    final data = docs.first.data() as Map<String, dynamic>;

    return Post(
      id: docs.first.id,
      topicId: data['topicId'],
      description: data['content'],
      date: data['date'].toDate(),
      title: data['title'],
      userUID: data['userUID'],
    );
  }

}