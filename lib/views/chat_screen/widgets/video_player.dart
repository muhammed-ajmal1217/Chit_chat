import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController controller;

  @override
  void initState() {
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((value) => {setState(() {})});
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            height: 220,
            width: 220,
            child: controller.value.isInitialized
                ? VideoPlayer(controller)
                : Container(),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              controller.value.isPlaying
                  ? controller.pause()
                  : controller.play();
            });
          },
          child: CircleAvatar(
            child: Icon(
                controller.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow_rounded,
                color: Colors.white),
            backgroundColor:
                const Color.fromARGB(255, 93, 92, 92).withOpacity(0.5),
          ),
        )
      ],
    );
  }
}
