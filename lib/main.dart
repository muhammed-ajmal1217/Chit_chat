import 'package:chitchat/controller/auth_provider.dart';
import 'package:chitchat/controller/chat_page_provider.dart';
import 'package:chitchat/controller/chat_provider.dart';
import 'package:chitchat/controller/friend_suggestion_provider.dart';
import 'package:chitchat/controller/friends_request_accept_provider.dart';
import 'package:chitchat/controller/login_provider.dart';
import 'package:chitchat/controller/phone_request_provider.dart';
import 'package:chitchat/firebase_options.dart';
import 'package:chitchat/main_widgets/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [      
        ChangeNotifierProvider(create: (context) => LoginProvider(),),
        ChangeNotifierProvider(create: (context) => FriendSuggestionProvider(),),
        ChangeNotifierProvider(create: (context) => PhoneReqProvider(),),
        ChangeNotifierProvider(create: (context) => AuthenticationProvider(),),
        ChangeNotifierProvider(create: (context) => FirebaseProvider(),),
        ChangeNotifierProvider(create: (context) => FriendshipProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}