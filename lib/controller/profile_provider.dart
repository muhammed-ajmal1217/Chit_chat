import 'package:chitchat/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  AuthenticationService service = AuthenticationService();
  String profileUrl = '';
  String _userName = '';
  String get userName => _userName;
  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  Future<void> updateUserName() async {
    _userName = await service.getUserName();
    notifyListeners(); 
  }

  Future<void> retrieveProfilePictureUrl() async {
    profileUrl = await service.getProfilePictureUrl();
    notifyListeners(); 
  }

  Future<void> restoreFavoriteState(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? favoriteList = prefs.getBool(userId);
    _isFavorite = favoriteList ?? false;
    notifyListeners();
  }
    Future<void> toggleFavoriteState(String userId) async {
    _isFavorite = !_isFavorite;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(userId, _isFavorite);
    notifyListeners();
  }
  
}
