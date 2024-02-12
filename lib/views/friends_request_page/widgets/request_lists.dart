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
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: mainGradient(),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60),bottomLeft: Radius.circular(60),topRight: Radius.circular(30)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ListTile(
                    title: Text(
                      'User  $personNumber',
                      style:
                          GoogleFonts.raleway(color: Colors.white, fontSize: 14),
                    ),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/Designer (2).png'),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        requestAccept_Reject(Icons.check),
                        spacingWidth(9),
                        requestAccept_Reject(Icons.close),
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