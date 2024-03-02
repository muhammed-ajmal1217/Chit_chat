import 'package:chitchat/controller/chat_provider.dart';
import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/model/user_model.dart';
import 'package:chitchat/service/auth_service.dart';
import 'package:chitchat/service/chat_service.dart';
import 'package:chitchat/views/chat_bubble.dart';
import 'package:chitchat/views/user_profile/widgets/bottomsheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.user});
  final UserModel user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messagecontroller = TextEditingController();
  AuthenticationService service = AuthenticationService();

  @override
  void initState() {
    super.initState();
    final currentuserid = service.authentication.currentUser!.uid;
    Provider.of<FirebaseProvider>(context, listen: false)
        .getMessages(currentuserid, widget.user.userId ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: mainGradient()),
        ),
        title: Row(
          children: [
            goBackArrow(context),
            spacingWidth(size.width * 0.02),
            CircleAvatar(
              radius: size.height * 0.027,
              backgroundImage: AssetImage('assets/Designer.png'),
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
                    onTap: () {},
                    child: Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.white,
                    )),
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
                          onTap: () => Provider.of<FirebaseProvider>(context,listen: false)
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
          )
        ],
      ),
      backgroundColor: Color(0xff131313),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 40),
                    child: ChatBubble(service: service, size: size),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 5,
                    right: 5,
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: TextFormField(
                                controller: messagecontroller,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                                decoration: InputDecoration(
                                  fillColor: Colors.black,
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
                                      showBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return BottomSheetPage();
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
                          CircleAvatar(
                            child: Icon(
                              Icons.mic,
                              color: Colors.white,
                            ),
                            backgroundColor: Color.fromARGB(255, 26, 26, 26),
                            radius: size.height * 0.036,
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

  sendMessage() async {
    if (messagecontroller.text.isNotEmpty) {
      await ChatService().sendMessage(
          widget.user.userId ?? "", messagecontroller.text, "text");
      messagecontroller.clear();
    }
  }
}
