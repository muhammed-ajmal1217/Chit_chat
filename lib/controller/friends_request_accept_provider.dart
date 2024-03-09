
import 'package:chitchat/model/request_model.dart';
import 'package:chitchat/model/user_model.dart';
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

  Future<void> sendFriendRequest({required String recipientUserId,required String recieverName,required String userName}) async{
    final isGoogleSignIn = authService.isGoogleSignIn();
    final senderId = authService.authentication.currentUser!.uid;
    final senderName = isGoogleSignIn
        ? authService.authentication.currentUser!.displayName
        : userName;
    final request = RequestModel(
        senderId: senderId,
        senderName: senderName,
        recieverId: recipientUserId,
        recieverName: recieverName
        );
   await authService.firestore
        .collection('users')
        .doc(recipientUserId)
        .collection('friend_request')
        .add(request.toJson());
  }
//String senderId, String senderName,
void acceptFriendRequest(RequestModel? userData, String? currentUserName) async{
  final currentUserUid = authService.authentication.currentUser!.uid;
  final isGoogleSignIn = authService.isGoogleSignIn();
  currentUserName = isGoogleSignIn?authService.authentication.currentUser!.displayName:currentUserName;
  final senderFriend = RequestModel(senderId: userData?.senderId, senderName: userData?.senderName, recieverId: currentUserUid, recieverName: currentUserName);
  final receiverFriend = RequestModel(senderId: currentUserUid, senderName: currentUserName, recieverId: userData?.senderId, recieverName: userData?.senderName);
  final requestedPersonUid = userData?.senderId;

  await authService.firestore
      .collection('users')
      .doc(currentUserUid)
      .collection('friend_request')
      .where('sender_id', isEqualTo: userData?.senderId)
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      doc.reference.delete().then((_) {
        authService.firestore
            .collection('users')
            .doc(requestedPersonUid)
            .collection('friend_list')
            .add(receiverFriend.toJson())
            .then((_) {
          authService.firestore
              .collection('users')
              .doc(currentUserUid)
              .collection('friend_list')
              .add(senderFriend.toJson())
              .then((_) {
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
