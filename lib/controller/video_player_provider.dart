// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayerProvider extends ChangeNotifier {
//   late VideoPlayerController controller;

//   VideoPlayerProvider() {
//     // Initialize an empty controller
//     controller = VideoPlayerController.network('')
//       ..initialize().then((_) => notifyListeners());
//   }

//   void setVideoUrl(String videoUrl) {
//     // Initialize the controller with the provided video URL
//     controller = VideoPlayerController.network(videoUrl)
//       ..initialize().then((_) => notifyListeners());
//   }

//   void togglePlayPause() {
//     if (controller.value.isPlaying) {
//       controller.pause();
//     } else {
//       controller.play();
//     }
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
// }
