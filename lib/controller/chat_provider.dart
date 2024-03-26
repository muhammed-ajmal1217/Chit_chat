import 'dart:io';
import 'package:chitchat/model/message_model.dart';
import 'package:chitchat/model/user_model.dart';
import 'package:chitchat/service/auth_service.dart';
import 'package:chitchat/service/chat_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FirebaseProvider extends ChangeNotifier {
  List<UserModel> users = [];
  List<MessageModel> messages = [];
  List<UserModel> requests = [];
  List<UserModel> favoriteList = [];
  List<UserModel> filteredUsers = [];
  AuthenticationService authService = AuthenticationService();
  ChatService chatService = ChatService();
  ScrollController scrollController = ScrollController();

  List<UserModel> getAllUsers() {
    authService.firestore.collection('users').snapshots().listen((user) {
      users = user.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
      filteredUsers = users;
      notifyListeners();
    });
    return users;
  }

  List<MessageModel> getMessages(String currentuserid,String recieverId) {
    List ids = [currentuserid, recieverId];
    ids.sort();
    String chatroomid = ids.join("_");
    authService.firestore
        .collection("chat_room")
        .doc(chatroomid)
        .collection("messages")
        .orderBy("time", descending: false)
        .snapshots()
        .listen((message) {
      messages =
          message.docs.map((doc) => MessageModel.fromJson(doc.data())).toList();
      notifyListeners();
      scrollDown();
    });
    return messages;
  }

  Future<void> clearChat(String currentuserid, String recieverid) async {
    try {
      await chatService.clearChat(currentuserid, recieverid);
    } catch (e) {
      throw Exception('Exception = $e');
    }
    notifyListeners();
  }

  void scrollDown() => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });

  void pickDocument(String recieverId) async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (pickedFile != null) {
      String fileName = pickedFile.files[0].name;
      File file = File(pickedFile.files[0].path!);
      await chatService.uploadPdf(recieverId, fileName, file);
      print('PDF upload Successful');
    }
  }

  Future<void> addToFavorite({
    required String userId,
    required String name,
    required String chatId,
  }) async {
    UserModel favouriteUser = UserModel(userName: name, userId: chatId);
    try {
      await chatService.firestore
          .collection('users')
          .doc(userId)
          .collection('favourite_chats')
          .doc(chatId)
          .set(favouriteUser.toJson());
      notifyListeners();
    } catch (e) {
      print('Error adding to favorite: $e');
      rethrow;
    }
  }

  Future<void> removeFromFavorite(
      {required String userId, required String chatId}) async {
    try {
      await authService.firestore
          .collection('users')
          .doc(userId)
          .collection('favourite_chats')
          .doc(chatId)
          .delete();
      notifyListeners();
    } catch (error) {
      print("Error removing chat from favorites: $error");
      throw error;
    }
  }

  getAllFavorite() {
    authService.firestore
        .collection('users')
        .doc(authService.authentication.currentUser!.uid)
        .collection('favourite_chats')
        .snapshots()
        .listen((favorite) {
      favoriteList =
          favorite.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
    });
    return favoriteList;
  }

  void filterUsers(String query) {
    final lowercaseQuery = query.toLowerCase();
    filteredUsers = users.where((user) {
      final username = user.userName!.toLowerCase();
      return username.contains(lowercaseQuery);
    }).toList();
    notifyListeners();
  }

  void updateFilteredUsers(List<UserModel> filteredUsersList) {
    filteredUsers = filteredUsersList;
    notifyListeners();
  }
}
