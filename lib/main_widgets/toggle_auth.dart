import 'package:chitchat/controller/login_provider.dart';
import 'package:chitchat/views/login_page.dart';
import 'package:chitchat/views/signup_page.dart';
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
