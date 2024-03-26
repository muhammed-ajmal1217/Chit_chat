import 'package:chitchat/model/user_model.dart';
import 'package:chitchat/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendshipProvider extends ChangeNotifier {
  AuthenticationService authService = AuthenticationService();
  bool _isFriendAccepted = false;
  bool get isFriendAccepted => _isFriendAccepted;
  late List<UserModel> filteredUsers = [];
  List<String> friendIds = [];
  List<UserModel>friends=[];
  bool isAccepted = false;
  getRequest() {
    return authService.firestore
        .collection('users')
        .doc(authService.authentication.currentUser!.uid)
        .collection('friend_request')
        .snapshots()
        .map((request) =>
            request.docs.map((doc) => UserModel.fromJson(doc.data())).toList());
  }

Stream<List<UserModel>> getFriends() {
  try {
    return authService.firestore
        .collection('users')
        .doc(authService.authentication.currentUser!.uid)
        .collection('friend_list')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList());
  } catch (e) {
    print('Error fetching friends: $e');
    return Stream.empty();
  }
}



  Future<void> sendFriendRequest({
    required UserModel userData,
    required String userName,
    required String profilePic,
  }) async {
    final isGoogleSignIn = authService.isGoogleSignIn();
    final senderId = authService.authentication.currentUser!.uid;
    final senderName = isGoogleSignIn
        ? authService.authentication.currentUser!.displayName
        : userName;
    final request = UserModel(
        userId: senderId,
        userName: senderName,
        receiverId: userData.userId,
        recieverName: userData.userName,
        email: authService.authentication.currentUser!.email,
        profilePicture: profilePic,
        isRequested: true);
    await authService.firestore
        .collection('users')
        .doc(userData.userId)
        .collection('friend_request')
        .doc(userData.userId)
        .set(request.toJson());
    userData.isRequested = true;
    print('request_sended');
    notifyListeners();
  }
  Stream getRequestStream(UserModel userData) {
  return authService.firestore
      .collection('users')
      .doc(userData.userId)
      .collection('friend_request')
      .doc(userData.userId)
      .snapshots();
}


  Future<void> deleteSentFriendRequest(UserModel userDetails) async {
    await authService.firestore
        .collection('users')
        .doc(userDetails.userId)
        .collection('friend_request')
        .doc(userDetails.userId)
        .delete();
    userDetails.isRequested = false;
    notifyListeners();
  }


void loadRequestedStatus() async {
  final currentUserUid = authService.authentication.currentUser!.uid;
  for (final user in filteredUsers) {
    final prefs = await SharedPreferences.getInstance();
    final isRequestedCurrentUser =
        prefs.getBool('is_requested_${user.userId}-$currentUserUid') ?? false;
    user.isRequested = isRequestedCurrentUser;
    final isRequestedOtherUser =
        prefs.getBool('is_requested_$currentUserUid-${user.userId}') ?? false;
    user.isRequested = isRequestedOtherUser;
  }
  notifyListeners();
}





  void acceptFriendRequest({
    required UserModel? userData,
    required String? currentUserName,
    required String profilePic,
  }) async {
    try {
      final currentUserUid = authService.authentication.currentUser!.uid;
      final currentUserEmail = authService.authentication.currentUser!.email;
      final isGoogleSignIn = authService.isGoogleSignIn();
      currentUserName = isGoogleSignIn
          ? authService.authentication.currentUser!.displayName
          : currentUserName;

      if (userData == null || userData.userId == null) {
        print('User data is null');
        return;
      }
      final senderFriend = UserModel(
          userId: userData.userId,
          userName: userData.userName,
          receiverId: currentUserUid,
          email: currentUserEmail,
          profilePicture: profilePic,
          recieverName: currentUserName,
          isAccepted: true);
      final receiverFriend = UserModel(
        userId: currentUserUid,
        userName: currentUserName,
        receiverId: userData.userId,
        recieverName: userData.userName,
        profilePicture: userData.profilePicture,
        email: userData.email,
        isAccepted: true,
      );
      userData.isAccepted = true;
      notifyListeners();
      final querySnapshot = await authService.firestore
          .collection('users')
          .doc(currentUserUid)
          .collection('friend_request')
          .where('userid', isEqualTo: userData.userId)
          .get();
      if (querySnapshot.docs.isEmpty) {
        print('No friend request found for deletion.');
        return;
      }
      for (final doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      await authService.firestore
          .collection('users')
          .doc(userData.userId)
          .collection('friend_list')
          .add(senderFriend.toJson());
      await authService.firestore
          .collection('users')
          .doc(currentUserUid)
          .collection('friend_list')
          .add(receiverFriend.toJson());
      notifyListeners();
    } catch (error) {
      print('Error accepting friend request: $error');
    }
  }

  Future<bool> checkFriendRequestAccepted(String userId) async {
    try {
      final currentUserUid = authService.authentication.currentUser!.uid;
      final querySnapshot = await authService.firestore
          .collection('users')
          .doc(currentUserUid)
          .collection('friend_list')
          .where('userid', isEqualTo: userId)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        var is_Accepted = doc.get('is_accepted') ?? false;
        isAccepted = is_Accepted;
        return isAccepted;
      } else {
        print('No friend request found for the user.');
        return false;
      }
    } catch (error) {
      print('Error checking friend request acceptance: $error');
      return false;
    }
  }

  void rejectFriendRequest(String userId) async {
    try {
      final currentUserUid = authService.authentication.currentUser!.uid;
      final querySnapshot = await authService.firestore
          .collection('users')
          .doc(currentUserUid)
          .collection('friend_request')
          .where('userid', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        print('No friend request found for rejection.');
        return;
      }
      for (final doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      notifyListeners();
    } catch (error) {
      print('Error rejecting friend request: $error');
    }
  }
}
