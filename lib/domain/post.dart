class Post {
  final String id;
  final String userUID;
  final String topicId;
  final String title;
  final String description;
  final int likes;
  final List<String> mediaURIs;
  final DateTime date;

  Post({required this.id, required this.date, required this.title, required this.description, required this.userUID, this.likes = 0, this.mediaURIs = const [], required this.topicId});

  // factory Post.fromJson(Map<String, dynamic> json) {
  //   return Post(
  //     id: json['id'],
  //     title: json['title'],
  //     description: json['description'],
  //     userUID: json['userUID'],
  //     likes: json['likes'],
  //     mediaURIs: json['mediaURIs'],
  //     topicId: json['topicId'],
  //     date: json['date'].toDate()
  //   );
  // }

  @override
  String toString() {
    return "Post: $title";
  }
}