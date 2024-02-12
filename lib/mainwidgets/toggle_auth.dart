import 'package:chitchat/controller/login_provider.dart';
import 'package:chitchat/views/loginpage.dart';
import 'package:chitchat/views/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToggleAuth extends StatefulWidget {
  const ToggleAuth({super.key});

  @override
  State<ToggleAuth> createState() => _ToggleAuthState();
}

class _ToggleAuthState extends State<ToggleAuth> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    if (loginProvider.showLogin) {
      return LoginPage(
        showSignUp: loginProvider.toggleScreen,
      );
    } else {
      return SignUpPage(
        showLogin: loginProvider.toggleScreen,
      );
    }
  }
}
