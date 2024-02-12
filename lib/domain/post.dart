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
  final Location? location;
  bool likedByUser; // This field is not persisted in the database,
  // but it is used to keep track of whether the current user has liked the post.

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
      });

  @override
  String toString() {
    return "Post: $title";
  }
}

class Location {
  final double latitude;
  final double longitude;

  Location({required this.latitude, required this.longitude});

  @override
  String toString() {
    return "Location: $latitude, $longitude";
  }

  GeoPoint toGeoPoint() {
    return GeoPoint(latitude, longitude);
  }

  factory Location.fromGeoPoint(GeoPoint geoPoint) {
    return Location(latitude: geoPoint.latitude, longitude: geoPoint.longitude);
  }
}
