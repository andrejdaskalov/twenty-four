
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@injectable
class MediaApi {
  final storageRef = FirebaseStorage.instance;
  Future<String> getDownloadURL(String path) async {
    return await storageRef.refFromURL(path).getDownloadURL();
  }

  Future<String> uploadImage(String path) async {
    final file = File(path);
    final snapshot = await storageRef.ref().child(path).putFile(file);
    return "gs://${snapshot.ref.bucket}/${snapshot.ref.fullPath}";
  }

}