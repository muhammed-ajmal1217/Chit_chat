import 'package:audioplayers/audioplayers.dart';
import 'package:chitchat/controller/chat_provider.dart';
import 'package:chitchat/service/auth_service.dart';
import 'package:chitchat/views/chat_screen/widgets/video_player.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatefulWidget {
  ChatBubble({
    Key? key,
    required this.service,
    required this.size,
    this.audioFilePath,
    this.audioPlayer,
  }) : super(key: key);

  final AuthenticationService service;
  final Size size;
  final String? audioFilePath;
  AudioPlayer? audioPlayer;

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  void initState() {
    super.initState();
    widget.audioPlayer = AudioPlayer();
  }
  @override
  Widget build(BuildContext context) {

    return Consumer<FirebaseProvider>(builder: (context, value, child) {
      if (value.messages.isEmpty) {
        return Center(
          child: Lottie.asset(
            "assets/Animation - 1708780605424 (1).json",
            width: 230,
          ),
        );
      } else {
        return ListView.builder(
          controller: value.scrollController,
          itemCount: value.messages.length,
          itemBuilder: (context, index) {
                List<bool> isMessagePlayingList = List.filled(
        value.messages.length, false);
            final chats = value.messages[index];
            DateTime dateTime = chats.time!.toDate();
            String formattedTime = DateFormat.jm().format(dateTime);

            var alignment =
                chats.senderId == widget.service.authentication.currentUser!.uid
                    ? Alignment.centerRight
                    : Alignment.centerLeft;
            var bubblecolor =
                chats.senderId == widget.service.authentication.currentUser!.uid
                    ? Color.fromARGB(255, 47, 60, 68)
                    : Color.fromARGB(255, 4, 93, 108);

            var borderradius =
                chats.senderId == widget.service.authentication.currentUser!.uid
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      )
                    : const BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      );

            if (chats.messagetype == "text") {
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                child: Align(
                  alignment: alignment,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: widget.size.height * 0.05,
                      minWidth: widget.size.width * 0.2,
                      maxWidth: widget.size.width * 0.7,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: bubblecolor,
                        borderRadius: borderradius,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              chats.content!,
                              style: GoogleFonts.raleway(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(
                              width: widget.size.width * 0.2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    formattedTime,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else if (chats.messagetype == "image") {
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                child: Align(
                  alignment: alignment,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: widget.size.height * 0.05,
                      minWidth: widget.size.width * 0.2,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: bubblecolor,
                        borderRadius: borderradius,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                chats.content!,
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: widget.size.width * 0.2,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  formattedTime,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else if (chats.messagetype == "video") {
              print(chats.content!);
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                child: Align(
                  alignment: alignment,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: widget.size.height * 0.05,
                      minWidth: widget.size.width * 0.2,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: bubblecolor,
                        borderRadius: borderradius,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            VideoPlayerWidget(videoUrl: chats.content!),
                            SizedBox(
                              width: widget.size.width * 0.2,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  formattedTime,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else if (chats.messagetype == "pdf") {
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                child: Align(
                  alignment: alignment,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: widget.size.height * 0.05,
                      minWidth: widget.size.width * 0.2,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: bubblecolor,
                        borderRadius: borderradius,
                      ),
                      child: InkWell(
                        onTap: () {
                          _openPdf(chats.content!, context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.picture_as_pdf,
                                size: 50,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: widget.size.width * 0.2,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    formattedTime,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else if (chats.messagetype == "mp3") {
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                child: Align(
                  alignment: alignment,
                  child: SizedBox(
                    width: widget.size.width * 0.7,
                    child: Container(
                      decoration: BoxDecoration(
                        color: bubblecolor,
                        borderRadius: borderradius,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          onTap: () {
                            if (!isMessagePlayingList[index]) {
                              playVoice(
                                  chats.content!, isMessagePlayingList, index);
                            } else {
                              widget.audioPlayer?.pause();
                            }
                            setState(() {
                              isMessagePlayingList[index] =
                                  !isMessagePlayingList[index];
                            });
                          },
                          child: !isMessagePlayingList[index]
                              ? Row(
                                  children: [
                                    Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 1,
                                        width: widget.size.width * 0.55,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                )
                              : Row(
                                  children: [
                                    Icon(
                                      Icons.pause,
                                      color: Colors.white,
                                    ),
                                    Lottie.asset(
                                      "assets/Animation - 1710842378300.json",
                                      width: 230,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return SizedBox();
            }
          },
        );
      }
    });
  }

  void _openPdf(String pdfUrl, BuildContext context) async {
    PDFDocument doc = await PDFDocument.fromURL(pdfUrl);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFViewer(document: doc),
      ),
    );
  }

  playVoice(
      String audioFilePath, List<bool> isMessagePlayingList, int index) async {
    try {
      await widget.audioPlayer?.play(UrlSource(audioFilePath));
      widget.audioPlayer?.onPlayerComplete.listen((event) {
        setState(() {
          isMessagePlayingList[index] = false;
        });
      });
    } catch (e) {
      print('Voice play error: $e');
    }
  }

  void dispose() {
    widget.audioPlayer!.dispose();
    super.dispose();
  }
}
