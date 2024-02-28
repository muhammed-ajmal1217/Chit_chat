import 'package:chitchat/mainwidgets/toggle_auth.dart';
import 'package:chitchat/views/chat_screen/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ChatListPage();
          }else{
            return ToggleAuth();
          }
        },
        )
    );
  }
}