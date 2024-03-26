import 'package:flutter/material.dart';
import 'package:chitchat/model/story_view_mode.dart';
import 'package:chitchat/views/chat_screen/widgets/video_player.dart';
import 'package:video_player/video_player.dart';

class StoryViewerPage extends StatefulWidget {
  final List<Story> stories;
  final int initialIndex;

  const StoryViewerPage({Key? key, required this.stories, this.initialIndex = 0})
      : super(key: key);

  @override
  _StoryViewerPageState createState() => _StoryViewerPageState();
}

class _StoryViewerPageState extends State<StoryViewerPage> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    _currentPage = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (details) {
          double screenWidth = MediaQuery.of(context).size.width;
          if (details.localPosition.dx < screenWidth / 3) {
            _previousPage();
          } else if (details.localPosition.dx > screenWidth * 2 / 3) {
            _nextPage();
          } else {
            
          }
        },
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemCount: widget.stories.length,
          itemBuilder: (context, index) {
            final story = widget.stories[index];
            return Stack(
              children: [
                if (story.mediaType == 'image') ...[
                  Image.network(
                    story.media ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ] else ...[
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: VideoWidget(videoUrl: story.media??'',)
                  ),
                ],
                Positioned(
                  top: 50.0,
                  left: 20.0,
                  child: Text(
                    story.name ?? '',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _nextPage() {
    if (_currentPage < widget.stories.length - 1) {
      _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
    }
  }
}
class VideoWidget extends StatefulWidget {
  final String videoUrl;

  const VideoWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoWidget> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) {
        setState(() {
          controller.play(); // Auto-play the video
        });
      });
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
            height: double.infinity,
            width: 500,
            child: controller.value.isInitialized
                ? VideoPlayer(controller)
                : Container(),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              controller.value.isPlaying ? controller.pause() : controller.play();
            });
          },
          child: CircleAvatar(
            child: Icon(
              controller.value.isPlaying ? Icons.pause : Icons.play_arrow_rounded,
              color: Colors.white,
            ),
            backgroundColor: const Color.fromARGB(255, 93, 92, 92).withOpacity(0.5),
          ),
        )
      ],
    );
  }
}

