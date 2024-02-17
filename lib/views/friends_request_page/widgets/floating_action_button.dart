import 'package:chitchat/views/friends_suggestions.dart';
import 'package:flutter/material.dart';

class NavigatetoFriendsAdding extends StatelessWidget {
  const NavigatetoFriendsAdding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
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
    );
  }
}