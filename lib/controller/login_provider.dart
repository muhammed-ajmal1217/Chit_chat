import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier{
  bool showLogin=true;
    toggleScreen(){
      showLogin=!showLogin;
      notifyListeners();
  }
}