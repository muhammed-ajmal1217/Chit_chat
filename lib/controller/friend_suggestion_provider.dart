import 'package:chitchat/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendSuggestionProvider extends ChangeNotifier {
  late List<bool> isClicked = List<bool>.generate(20, (index) => false);
  isClickedon(index) {
    isClicked[index] = !isClicked[index];
    notifyListeners();
  }



}
