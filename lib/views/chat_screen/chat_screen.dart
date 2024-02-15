import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/model/story_view_mode.dart';
import 'package:chitchat/views/chat_screen/widgets/circle_border_widget.dart';
import 'package:chitchat/views/chat_screen/widgets/floating_action_button.dart';
import 'package:chitchat/views/chat_screen/widgets/helpers.dart';
import 'package:chitchat/views/drawer/drawer.dart';
import 'package:chitchat/views/chat_page.dart';
import 'package:chitchat/views/friends_request_page/friends_request_page.dart';
import 'package:chitchat/views/story_viewer_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int personNumber = 0;
  final List<Story> stories = [
    Story(
      imageUrl: 'assets/Designer (2).png',
      title: 'Story 1',
    ),
    Story(
      imageUrl: 'assets/Designer (2).png',
      title: 'Story 2',
    ),
    Story(
      imageUrl: 'assets/Designer (2).png',
      title: 'Story 3',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Row(
          children: [
            spacingWidth(width * 0.02),
            CircleAvatar(
              radius: height * 0.02,
              backgroundImage: AssetImage('assets/Designer (2).png'),
            ),
            spacingWidth(width * 0.03),
            Text(
              'Chitchat',
              style: GoogleFonts.aBeeZee(color: Colors.white),
            ),
          ],
        ),
      ),
      endDrawer: CustomDrawer(),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            height: height * 0.08,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  prefixStyle: TextStyle(color: Colors.grey),
                  hintText: 'Search...',
                  hintStyle:
                      GoogleFonts.raleway(color: Colors.grey, fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.210,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, bottom: 4),
                          child: Text(
                            'Relations',
                            style: GoogleFonts.raleway(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                        Container(
                          height: height * 0.15,
                          child: Row(
                            children: [
                              spacingWidth(width * 0.018),
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 20,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(0.1),
                                              child: CircleAvatar(
                                                radius: 35,
                                                backgroundColor: Colors.black,
                                                child: Icon(Icons.add,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          spacingHeight(height * 0.01),
                                          Text(
                                            'Add Story',
                                            style: GoogleFonts.raleway(
                                                color: Colors.white,
                                                fontSize: height * 0.012),
                                          )
                                        ],
                                      );
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 8),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            StoryViewerPage(
                                                                story: stories[
                                                                    index]),
                                                      ),
                                                    );
                                                  },
                                                  child:
                                                      GradientBorderCircleAvatar(
                                                    imageUrl:
                                                        'assets/Designer.png',
                                                    radius: height * 0.042,
                                                    gradientColors: [
                                                      Color.fromARGB(
                                                          255, 163, 239, 249),
                                                      Color.fromARGB(
                                                          255, 9, 247, 255),
                                                      Color.fromARGB(
                                                          255, 6, 123, 121),
                                                      Color.fromARGB(
                                                          255, 57, 2, 255),
                                                      Color.fromARGB(
                                                          255, 13, 96, 100),
                                                    ],
                                                    borderWidth: 3.0,
                                                  ),
                                                ),
                                              ),
                                              spacingHeight(height * 0.01),
                                              Text(
                                                'User ${personNumber + index}',
                                                style: GoogleFonts.raleway(
                                                    color: Colors.white,
                                                    fontSize: height * 0.012),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        messageHeadText(
                            height: height,
                            height1: 0.017,
                            color: Colors.white,
                            text: 'Your message'),
                        messageHeadText(
                            height: height,
                            height1: 0.017,
                            color: Colors.red,
                            text: 'Unread message(${personNumber})'),
                      ],
                    ),
                  ),
                  spacingHeight(10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      final personNumber = index + 1;
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 8, bottom: 8, left: 8),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChatPage(
                                person: personNumber,
                              ),
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Container(
                              height: height * 0.095,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  gradient: mainGradient(),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      bottomLeft: Radius.circular(50))),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'User $personNumber',
                                        style: GoogleFonts.raleway(
                                            color: Colors.white,
                                            fontSize: height * 0.017),
                                      ),
                                      Text(
                                        'The last message displayed in here',
                                        style: TextStyle(
                                            fontSize: height * 0.014,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  leading: InkWell(
                                    onTap: () {},
                                    child: CircleAvatar(
                                      radius: height * 0.03,
                                      backgroundImage:
                                          AssetImage('assets/Designer (2).png'),
                                    ),
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      CircleAvatar(
                                        radius: height * 0.012,
                                        backgroundColor:
                                            Color.fromARGB(255, 2, 191, 156),
                                        child: Center(
                                          child: Text(
                                            '$personNumber',
                                            style: TextStyle(
                                                fontSize: height * 0.014,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      spacingHeight(height * 0.004),
                                      Text(
                                        '${DateFormat('hh:mm a').format(DateTime.now())}',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: height * 0.010),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: NavigateToFriends(),
    );
  }


}
