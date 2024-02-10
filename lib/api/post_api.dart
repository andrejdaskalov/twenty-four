import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../domain/post.dart';

@injectable
class PostApi {
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');
  Future<List<Post>> getPostsByTopicId(String topicId) async {
    final snapshot = await posts
        .where('topicId', isEqualTo: topicId)
        .orderBy('date')
        .get();
    final docs = snapshot.docs;
    if (docs.isEmpty) {
      return [
        Post(
          id: "0",
          topicId: "0",
          title: 'No post for this topic',
          date: DateTime.now(),
          description: '',
          userUID: '',
        )
      ];
    }
    final data = docs.map((e) {
      final element = e.data() as Map<String, dynamic>;
      element['id'] = e.id;
      return element;
    }).toList();

    return data.map((e) => Post(
      id: e['id'],
      title: e['title'],
      description: e['description'],
      userUID: e['userUID'],
      likes: e['likes'],
      mediaURIs: List<String>.from(e['mediaURIs']),
      topicId: e['topicId'],
      date: e['date'].toDate()
    )).toList();
  }

}