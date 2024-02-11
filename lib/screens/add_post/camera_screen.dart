import 'package:better_open_file/better_open_file.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/pigeon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:twenty_four/screens/add_post/add_post.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CameraAwesomeBuilder.awesome(
      saveConfig: SaveConfig.photo(
          exifPreferences: ExifPreferences(saveGPSLocation: true)),
      bottomActionsBuilder: (state) => AwesomeBottomActions(
        state: state,
        right: null,
        captureButton: FloatingActionButton(
          onPressed: () {
            state.when(
              onPhotoMode: (photoState) =>
                  photoState.takePhoto().then((captureRequest) {
                captureRequest.when(
                  single: (photo) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddPost(imagePath: photo.file!.path)));
                  },
                );
              }),
            );
          },
          child: const Icon(Icons.camera_alt_sharp),
        ),
      ),
    );
  }
}
