import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String? id;
  final String userUID;
  final String topicId;
  final String title;
  final String description;
  final int likes;
  List<String> mediaURIs;
  final DateTime date;
  final String? location;
  bool likedByUser; // This field is not persisted in the database,
  // but it is used to keep track of whether the current user has liked the post.
  final String? userName;

  Post({
      this.id,
      required this.date,
      required this.title,
      required this.description,
      required this.userUID,
      this.likes = 0,
      this.mediaURIs = const [],
      required this.topicId,
      this.location,
      this.likedByUser = false,
      this.userName,
      });

  @override
  String toString() {
    return "Post: $title";
  }
}

