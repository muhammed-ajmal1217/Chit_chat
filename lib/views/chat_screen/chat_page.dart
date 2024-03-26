import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:chitchat/constants/user_icon.dart';
import 'package:chitchat/controller/chat_provider.dart';
import 'package:chitchat/controller/friends_request_accept_provider.dart';
import 'package:chitchat/controller/profile_provider.dart';
import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/model/user_model.dart';
import 'package:chitchat/service/auth_service.dart';
import 'package:chitchat/service/chat_service.dart';
import 'package:chitchat/views/chat_screen/widgets/chat_bubble.dart';
import 'package:chitchat/views/user_profile/widgets/bottomsheet_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({
    Key? key,
    required this.user,
  }) : super(key: key);
  final UserModel user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isFavorite = false;
  TextEditingController messageController = TextEditingController();
  AuthenticationService service = AuthenticationService();
  FirebaseAuth auth = FirebaseAuth.instance;
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  AudioPlayer audioPlayer = AudioPlayer();
  String? audioFilePath;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    initRecorder();
    final currentUserId = service.authentication.currentUser!.uid;
    Provider.of<FirebaseProvider>(context, listen: false)
        .getMessages(currentUserId, widget.user.userId ?? '');
    Provider.of<ProfileProvider>(context, listen: false)
        .restoreFavoriteState(widget.user.userId ?? '');
    Provider.of<FriendshipProvider>(context, listen: false).getFriends();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final pro = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 19, 25, 35),
        title: Row(
          children: [
            goBackArrow(context),
            spacingWidth(size.width * 0.02),
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: size.height * 0.027,
              backgroundImage: widget.user.profilePicture == null
                  ? NetworkImage(UserIcon.proFileIcon)
                  : NetworkImage(widget.user.profilePicture ?? ''),
            ),
            spacingWidth(size.width * 0.02),
            GestureDetector(
              onTap: () {},
              child: Text(
                widget.user.userName!,
                style: GoogleFonts.raleway(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    final provider =
                        Provider.of<FirebaseProvider>(context, listen: false);
                    final currentUserId = auth.currentUser!.uid;

                    if (!pro.isFavorite) {
                      await provider.addToFavorite(
                        userId: currentUserId,
                        name: widget.user.userName!,
                        chatId: widget.user.userId!,
                      );
                      storeFavoriteChatLocally(
                        chatId: widget.user.userId!,
                        isFavorite: true,
                      );
                    } else {
                      await provider.removeFromFavorite(
                        userId: currentUserId,
                        chatId: widget.user.userId!,
                      );
                      removeFavoriteChatLocally(chatId: widget.user.userId!);
                    }
                    pro.toggleFavoriteState(widget.user.userId ?? '');
                  },
                  child: Icon(
                    pro.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: pro.isFavorite ? Colors.red : Colors.white,
                  ),
                ),
                spacingWidth(10),
                InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.phone,
                      color: Colors.white,
                    )),
                spacingWidth(10),
                InkWell(
                  onTap: () {
                    showMenu(
                      color: Color.fromARGB(255, 26, 26, 26),
                      context: context,
                      position: RelativeRect.fromLTRB(
                        MediaQuery.of(context).size.width,
                        0,
                        0,
                        0,
                      ),
                      items: [
                        PopupMenuItem(
                          child: Text(
                            'View profile',
                            style: GoogleFonts.raleway(color: Colors.white),
                          ),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'Media',
                            style: GoogleFonts.raleway(color: Colors.white),
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          onTap: () => Provider.of<FirebaseProvider>(context,
                                  listen: false)
                              .clearChat(
                                  service.authentication.currentUser!.uid,
                                  widget.user.userId!),
                          child: Text(
                            'Clear chat',
                            style: GoogleFonts.raleway(color: Colors.white),
                          ),
                          value: 3,
                        ),
                        PopupMenuItem(
                          child: Text(
                            'Block user',
                            style: GoogleFonts.raleway(color: Colors.white),
                          ),
                          value: 4,
                        ),
                      ],
                    );
                  },
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 19, 25, 35),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                height: 1,
                width: double.infinity,
                color: Color.fromARGB(255, 52, 68, 80),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 40),
                    child: ChatBubble(
                      service: service,
                      size: size,
                      audioFilePath: audioFilePath,
                      audioPlayer: audioPlayer,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 5,
                    right: 5,
                    child: Container(
                      height: 130,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 65),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                isRecording
                                    ? StreamBuilder<RecordingDisposition>(
                                        stream: recorder.onProgress,
                                        builder: (context, snapshot) {
                                          final duration = snapshot.hasData
                                              ? snapshot.data!.duration
                                              : Duration.zero;
                                          String twoDigits(int n) =>
                                              n.toString().padLeft(0);
                                          final twoDigitMinutes = twoDigits(
                                              duration.inMinutes.remainder(60));
                                          final twoDigitSeconds = twoDigits(
                                              duration.inSeconds.remainder(60));
                                          return Text(
                                            "$twoDigitMinutes:$twoDigitSeconds",
                                            style:
                                                TextStyle(color: Colors.white),
                                          );
                                        },
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: TextFormField(
                                    controller: messageController,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                    decoration: InputDecoration(
                                      fillColor:
                                          Color.fromARGB(255, 19, 25, 35),
                                      filled: true,
                                      hintText: 'Message...',
                                      hintStyle: GoogleFonts.raleway(
                                          color: Colors.white, fontSize: 12),
                                      floatingLabelStyle:
                                          TextStyle(color: Colors.white),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                height: size.height * 0.15,
                                                child: BottomSheetPage(
                                                    user: widget.user),
                                              );
                                            },
                                          );
                                        },
                                        child: Icon(
                                          Icons.attach_file,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                child: CircleAvatar(
                                  child: Icon(
                                          Icons.mic,
                                          color: Colors.white,
                                        ),
                                  backgroundColor:
                                      Color.fromARGB(255, 26, 34, 46),
                                  radius: size.height * 0.036,
                                ),
                                onTap: () async {
                                  setState(() {
                                    isRecording = !isRecording;
                                  });

                                  if (recorder.isRecording) {
                                    await stop();
                                  } else {
                                    await record();
                                  }
                                },
                              ),
                              spacingWidth(size.width * 0.003),
                              InkWell(
                                onTap: () {
                                  sendMessage();
                                },
                                child: CircleAvatar(
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                  backgroundColor: Color(0xff02B4BF),
                                  radius: size.height * 0.036,
                                ),
                              ),
                              spacingWidth(size.width * 0.01),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future record() async {
    if (!isRecorderReady) {
      return;
    }
    await recorder.startRecorder(toFile: 'audio');
  }

  Future stop() async {
    if (!isRecorderReady) {
      return;
    }
    final path = await recorder.stopRecorder();
    final audioFile = path ?? '';
    print(path);
    audioFilePath = audioFile;
    ChatService().uploadAudio(widget.user.userId ?? '', audioFilePath ?? '');
    print('Recorded audio: $audioFilePath');
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      ChatService().sendMessage(
          widget.user.userId ?? "", messageController.text, "text");
      messageController.clear();
    }
  }

  storeFavoriteChatLocally(
      {required String chatId, required bool isFavorite}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(chatId, isFavorite);
  }

  void removeFavoriteChatLocally({required String chatId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(chatId);
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Micropjone permission not granted';
    }
    await recorder.openRecorder();
    isRecorderReady = true;
    recorder.setSubscriptionDuration(
      Duration(milliseconds: 500),
    );
  }
}
