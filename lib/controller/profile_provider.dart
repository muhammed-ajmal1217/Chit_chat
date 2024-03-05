import 'package:chitchat/service/auth_service.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  AuthenticationService service = AuthenticationService();
  String _userName = '';
  String get userName => _userName;
  Future<void> updateUserName() async {
    _userName = await service.getUserName();
    notifyListeners(); 
  }
}
