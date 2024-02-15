import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/views/friends_request_page/widgets/friends_list.dart';
import 'package:chitchat/views/friends_request_page/widgets/helpers_widgets.dart';
import 'package:chitchat/views/friends_request_page/widgets/request_lists.dart';
import 'package:chitchat/views/friends_suggestions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Friends_RequestPage extends StatefulWidget {
  const Friends_RequestPage({Key? key}) : super(key: key);

  @override
  State<Friends_RequestPage> createState() => _Friends_RequestPageState();
}

class _Friends_RequestPageState extends State<Friends_RequestPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          bottom: TabBar(
            dividerColor: Colors.black,
            unselectedLabelColor: Colors.white,
            indicatorColor: Color(0xff02B4BF),
            labelStyle: GoogleFonts.raleway(color: Color(0xff02B4BF)),
            tabs: [
              Tab(
                child: tabBarContent(icon: Icons.check, text: 'Friends',height: height),
              ),
              Tab(child: tabBarContent(icon: Icons.group, text: 'Requests',height: height)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              color: Colors.black,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 30),
                    child: SizedBox(
                      height: height*0.050,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: Color.fromARGB(163, 255, 255, 255)
                              .withOpacity(0.1),
                          filled: true,
                          prefixIcon: Icon(Icons.search),
                          prefixStyle: TextStyle(color: Colors.grey),
                          hintText: 'Search...',
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 14),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ),
                  spacingHeight(height * 0.02),
                  friends_list(),
                ],
              ),
            ),
            FriendsRequest(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FriendsSuggestions(),
            ));
          },
          shape: CircleBorder(),
          backgroundColor: Color(0xffFA7B06),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
