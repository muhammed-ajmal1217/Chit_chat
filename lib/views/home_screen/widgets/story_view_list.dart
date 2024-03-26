import 'dart:io';

import 'package:chitchat/controller/friends_request_accept_provider.dart';
import 'package:chitchat/controller/profile_provider.dart';
import 'package:chitchat/model/story_view_mode.dart';
import 'package:chitchat/model/user_model.dart';
import 'package:chitchat/service/auth_service.dart';
import 'package:chitchat/service/chat_service.dart';
import 'package:chitchat/views/chat_screen/widgets/video_player.dart';
import 'package:chitchat/views/home_screen/widgets/story_picker.dart';
import 'package:chitchat/views/story_viewer_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StoryList extends StatefulWidget {
  StoryList({
    Key? key,
    required this.stories,
    required this.height,
  }) : super(key: key);

  final double height;
  final List<Story> stories;

  @override
  State<StoryList> createState() => _StoryListState();
}

class _StoryListState extends State<StoryList> {
  final AuthenticationService auth = AuthenticationService();
  FriendshipProvider friendshipProvider = FriendshipProvider();
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserModel>>(
      stream: friendshipProvider.getFriends(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); 
        } else {
          List<UserModel> friends = snapshot.data ?? [];
          print('Friends Count: ${friends.length}');
          bool currentUserAddedStory = widget.stories.any((story) => story.id == FirebaseAuth.instance.currentUser!.uid);
          List<Story> storiesToShow = [];
          if (currentUserAddedStory) {
            Story currentUserStory = widget.stories.firstWhere((story) => story.id == FirebaseAuth.instance.currentUser!.uid);
            storiesToShow.add(currentUserStory);
          }
          for (var friend in friends) {
            bool friendAddedStory = widget.stories.any((story) => story.id == friend.receiverId);
            if (friendAddedStory) {
              Story friendStory = widget.stories.firstWhere((story) => story.id == friend.receiverId);
              storiesToShow.add(friendStory);
            }
          }

          return SizedBox(
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: storiesToShow.length,
                    itemBuilder: (context, index) {
                      final data = storiesToShow[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => StoryViewerPage(
                                    stories: storiesToShow,
                                    initialIndex: index,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (data.mediaType == 'image') ...[
                                  Container(
                                    height: widget.height * 0.15,
                                    width: widget.height * 0.13,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.grey.withOpacity(0.5),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          storiesToShow[index].media ?? '',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ] else ...[
                                  Material(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey.withOpacity(0.5),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => StoryViewerPage(
                                              stories: storiesToShow,
                                              initialIndex: index,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: widget.height * 0.15,
                                        width: widget.height * 0.13,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: VideoPlayerWidget(
                                          videoUrl: data.media ?? '',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                SizedBox(height: widget.height * 0.002),
                                Text(
                                  data.name ?? '',
                                  style: GoogleFonts.raleway(
                                    color: Colors.white,
                                    fontSize: widget.height * 0.016,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (!currentUserAddedStory) ...[
                  InkWell(
                    onTap: () async {
                      PickedMedia? pickedMedia = await pickMediaFromGallery(context);
                      if (pickedMedia != null) {
                        Story newStory = Story(
                          media: pickedMedia.file!.path,
                          name: Provider.of<ProfileProvider>(context, listen: false).userName,
                          time: Timestamp.now(),
                          mediaType: pickedMedia.mediaType == MediaType.image ? 'image' : 'video',
                          id: auth.authentication.currentUser!.uid,
                        );
                        widget.stories.insert(0, newStory);
                        await ChatService().uploadStatus(newStory);
                        setState(() {
                          storiesToShow.insert(0, newStory);
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: widget.height * 0.15,
                            width: widget.height * 0.13,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Add Story',
                            style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        }
      },
    );
  }
}
