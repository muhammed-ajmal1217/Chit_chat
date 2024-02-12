import 'package:flutter/material.dart';

class ChatPageProvider extends ChangeNotifier{
  List messageList = [];
  TextEditingController messageController = TextEditingController();
    void addMessage() {
      if (messageController.text.trim().isNotEmpty) {
        messageList.add(messageController.text.trim());
        messageController.clear();
        notifyListeners();
      }
  }
}