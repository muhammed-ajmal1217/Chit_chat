
import 'package:chitchat/model/story_view_mode.dart';
import 'package:flutter/material.dart';

class StoryViewerPage extends StatelessWidget {
  final Story story;

  const StoryViewerPage({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(story.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(story.imageUrl),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  story.title,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}