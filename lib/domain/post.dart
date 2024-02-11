class Post {
  final String? id;
  final String userUID;
  final String topicId;
  final String title;
  final String description;
  final int likes;
  List<String> mediaURIs;
  final DateTime date;

  Post({this.id, required this.date, required this.title, required this.description, required this.userUID, this.likes = 0, this.mediaURIs = const [], required this.topicId});


  @override
  String toString() {
    return "Post: $title";
  }
}