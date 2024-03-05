
import 'package:chitchat/model/request_model.dart';
import 'package:chitchat/service/auth_service.dart';
import 'package:flutter/material.dart';

class FriendshipProvider extends ChangeNotifier {
  AuthenticationService authService = AuthenticationService();
  getRequest() {
    return authService.firestore
        .collection('users')
        .doc(authService.authentication.currentUser!.uid)
        .collection('friend_request')
        .snapshots()
        .map((request) => request.docs
            .map((doc) => RequestModel.fromJson(doc.data()))
            .toList());
  }
  getFriends() {
    return authService.firestore
        .collection('users')
        .doc(authService.authentication.currentUser!.uid)
        .collection('friend_list')
        .snapshots()
        .map((friends) => friends.docs
            .map((doc) => RequestModel.fromJson(doc.data()))
            .toList());
  }

  void sendFriendRequest(String recipientUserId, String userName) {
    final isGoogleSignIn = authService.isGoogleSignIn();
    final senderId = authService.authentication.currentUser!.uid;
    final senderName = isGoogleSignIn
        ? authService.authentication.currentUser!.displayName
        : userName;
    final request = RequestModel(
        senderId: senderId,
        senderName: senderName,
        recieverId: recipientUserId,
        );
    authService.firestore
        .collection('users')
        .doc(recipientUserId)
        .collection('friend_request')
        .add(request.toJson());
  }

void acceptFriendRequest(String senderId, String senderName,String currentUserName) {
  final currentUserUid = authService.authentication.currentUser!.uid;
  // final currentUserName = authService.authentication.currentUser!.displayName;
  
  // Create friend models for both sender and receiver
  final senderFriend = RequestModel(senderId: senderId, senderName: senderName, recieverId: currentUserUid, recieverName: currentUserName);
  final receiverFriend = RequestModel(senderId: currentUserUid, senderName: currentUserName, recieverId: senderId, recieverName: senderName);
  
  // Get the requested person's UID
  final requestedPersonUid = senderId;

  authService.firestore
      .collection('users')
      .doc(currentUserUid)
      .collection('friend_request')
      .where('sender_id', isEqualTo: senderId)
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      doc.reference.delete().then((_) {
        // Add the current user to the requested person's friend list
        authService.firestore
            .collection('users')
            .doc(requestedPersonUid)
            .collection('friend_list')
            .add(receiverFriend.toJson())
            .then((_) {
          // Friend added to requested person's friend list successfully
          // Now, add the requested person to the current user's friend list
          authService.firestore
              .collection('users')
              .doc(currentUserUid)
              .collection('friend_list')
              .add(senderFriend.toJson())
              .then((_) {
            // Friend request accepted successfully
          }).catchError((error) {
            print('Error adding friend to current user\'s friend list: $error');
          });
        }).catchError((error) {
          print('Error adding friend to requested person\'s friend list: $error');
        });
      }).catchError((error) {
        print('Error deleting friend request: $error');
      });
    });
  }).catchError((error) {
    print('Error accepting friend request: $error');
  });
}


}
