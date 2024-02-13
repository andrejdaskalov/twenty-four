class Topic {
  final String id;
  final String topic;
  final String color;
  final DateTime date;

  Topic({required this.id, required this.topic, required this.color, required this.date});

  @override
  String toString() {
    return topic;
  }
}