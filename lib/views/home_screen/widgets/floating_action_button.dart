import 'package:chitchat/views/friends_request_page/friends_request_page.dart';
import 'package:flutter/material.dart';

class NavigateToFriends extends StatelessWidget {
   NavigateToFriends({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Friends_RequestPage(),
        ));
      },
      backgroundColor: Color(0xff02B4BF),
      shape: CircleBorder(),
      child: Icon(Icons.chat_bubble_outline, color: Colors.white),
    );
  }
}