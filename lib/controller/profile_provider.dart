import 'package:chitchat/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  AuthenticationService service = AuthenticationService();
  String profileUrl = '';
  String _userName = '';
  String get userName => _userName;

  Future<void> updateUserName() async {
    _userName = await service.getUserName();
    notifyListeners(); 
  }

  Future<void> retrieveProfilePictureUrl() async {
    profileUrl = await service.getProfilePictureUrl();
    notifyListeners(); 
  }
  
}
