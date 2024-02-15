import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/views/chat_page.dart';
import 'package:chitchat/views/user_profile/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class friends_list extends StatelessWidget {
  const friends_list({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Expanded(
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          final personNumber = index + 1;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: height*0.09,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: mainGradient(),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    bottomLeft: Radius.circular(60),
                    topRight: Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListTile(
                  title: Text(
                    'Friend  $personNumber',
                    style:
                        GoogleFonts.raleway(color: Colors.white, fontSize: 14),
                  ),
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UserProfile(
                              index: personNumber,
                              )));
                    },
                    child: Hero(
                      tag: index,
                      child: CircleAvatar(
                        radius: height*0.035,
                        backgroundImage: AssetImage('assets/Designer (2).png'),
                      ),
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ChatPage(person: personNumber),
                          ));
                        },
                        child: Icon(
                          Icons.message,
                          color: Color.fromARGB(255, 10, 213, 189),
                        ),
                      ),
                      spacingWidth(width*0.06),
                      Icon(
                        Icons.remove_circle_outline,
                        color: Color.fromARGB(255, 244, 79, 54),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
