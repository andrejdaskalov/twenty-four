
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@injectable
class MediaApi {
  final storageRef = FirebaseStorage.instance;
  Future<String> getDownloadURL(String path) async {
    return await storageRef.refFromURL(path).getDownloadURL();
  }

}