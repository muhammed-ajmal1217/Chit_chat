import 'package:chitchat/controller/chat_page_provider.dart';
import 'package:chitchat/controller/friend_suggestion_provider.dart';
import 'package:chitchat/controller/login_provider.dart';
import 'package:chitchat/controller/phone_request_provider.dart';
import 'package:chitchat/mainwidgets/toggle_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChatPageProvider(),),
        ChangeNotifierProvider(create: (context) => LoginProvider(),),
        ChangeNotifierProvider(create: (context) => FriendSuggestionProvider(),),
        ChangeNotifierProvider(create: (context) => PhoneReqProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ToggleAuth(),
      ),
    );
  }
}