import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/views/friends_request_page/widgets/helpers_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendsRequest extends StatefulWidget {
  const FriendsRequest({super.key});

  @override
  State<FriendsRequest> createState() => _FriendsRequestState();
}

class _FriendsRequestState extends State<FriendsRequest> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          final personNumber = index + 1;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {},
              child: Container(
                height: height * 0.09,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 41, 33, 53).withOpacity(0.5),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                ),
                child: Center(
                  child: ListTile(
                    title: Text(
                      'User  $personNumber',
                      style:
                          GoogleFonts.raleway(color: Colors.white, fontSize: 14),
                    ),
                    leading: Container(
                        height: height * 0.065,
                        width: height * 0.065,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: AssetImage('assets/Designer (2).png'))),
                      ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        requestAccept_Reject(Icons.check,height),
                        spacingWidth(width*0.03),
                        requestAccept_Reject(Icons.close,height),
                      ],
                    ),
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