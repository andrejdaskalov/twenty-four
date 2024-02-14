import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../domain/post.dart';

@injectable
class PostApi {
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');
  Future<List<Post>> getPostsByTopicId(String topicId) async {
    final snapshot = await posts
        .where('topicId', isEqualTo: topicId)
        .orderBy('date', descending: false)
        .get();
    final docs = snapshot.docs;
    if (docs.isEmpty) {
      return [];
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
      date: e['date'].toDate(),
      location: e['location'],
      userName: e['userName'],
    )).toList();
  }

  Future<void> addPost(Post post) async {
    await posts.add({
      'title': post.title,
      'description': post.description,
      'mediaURIs': post.mediaURIs,
      'topicId': post.topicId,
      'date': post.date,
      'userUID': post.userUID,
      'likes': post.likes,
      'location': post.location,
    });
  }

  Future<void> likePost(String postId) async {
    await posts.doc(postId).update({
      'likes': FieldValue.increment(1),
    });
  }

  Future<void> unlikePost(String postId) async {
    await posts.doc(postId).update({
      'likes': FieldValue.increment(-1),
    });
  }

}