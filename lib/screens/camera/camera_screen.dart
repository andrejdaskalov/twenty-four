import 'package:better_open_file/better_open_file.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/pigeon.dart';
import 'package:flutter/material.dart';

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
              onPhotoMode: (photoState) => photoState.takePhoto().then((captureRequest) {
                captureRequest.when(
                  single: (photo) {
                    OpenFile.open(photo.file?.path ?? ""); // TODO: change to navigation to add post screen
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
