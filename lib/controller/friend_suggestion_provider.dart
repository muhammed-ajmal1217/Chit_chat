import 'package:flutter/material.dart';

class FriendSuggestionProvider extends ChangeNotifier{
  late List<bool> isClicked = List<bool>.generate(20, (index) => false);
  isClickedon(index){
    isClicked[index] = !isClicked[index];
    notifyListeners();
  }
}