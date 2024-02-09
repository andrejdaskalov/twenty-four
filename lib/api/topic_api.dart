import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../domain/topic.dart';

@injectable
class TopicApi {
  CollectionReference topics = FirebaseFirestore.instance.collection('topics');

  Future<Topic> getTodayTopic() async {
    final today = DateTime.now();
    final snapshot = await topics
        .where('date', isGreaterThanOrEqualTo: today.copyWith(hour: 0, minute: 0, second: 0, millisecond: 0))
        .orderBy('date')
        .limit(1)
        .get();
    final docs = snapshot.docs;
    if (docs.isEmpty) {
      return Topic(
        id: '0',
        topic: 'No topic for today',
        color: '0xFFFFFFFF',
        date: DateTime.now(),
      );
    }
    final data = docs.first.data() as Map<String, dynamic>;

    return Topic(
      id: docs.first.id,
      topic: data['topic'] ,
      color: data['color'],
      date: data['date'].toDate(),
    );
  }



}