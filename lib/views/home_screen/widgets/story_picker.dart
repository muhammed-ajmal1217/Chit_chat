import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; 

enum MediaType {
  image,
  video,
}

class PickedMedia {
  final PlatformFile? file; 
  final MediaType? mediaType;

  PickedMedia({this.file, this.mediaType});
}

Future<PickedMedia?> pickMediaFromGallery(BuildContext context) async {
  try {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.media,
      allowMultiple: false,
    );
    if (pickedFile != null) {
      MediaType? mediaType = await showDialog<MediaType>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select Media Type"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, MediaType.image);
                  },
                  child: Text("Image"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, MediaType.video);
                  },
                  child: Text("Video"),
                ),
              ],
            ),
          );
        },
      );
      return PickedMedia(file: pickedFile.files.first, mediaType: mediaType); 
    }
  } catch (e) {
    print('Error picking media: $e');
  }
  return null;
}
