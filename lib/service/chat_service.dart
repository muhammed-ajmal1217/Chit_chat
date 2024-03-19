import 'dart:io';
import 'package:chitchat/model/message_model.dart';
import 'package:chitchat/model/read_unread_model.dart';
import 'package:chitchat/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  AuthenticationService authService = AuthenticationService();
  Reference storage = FirebaseStorage.instance.ref();
  String downloadurl = "";

  sendMessage(String recieverId, String message, String messagetype) async {
    final String currentUserId = firebaseAuth.currentUser!.uid;
    final String currentuseremail = firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    MessageModel newmessage = MessageModel(
        messagetype: messagetype,
        content: message,
        recieverId: recieverId,
        senderId: currentUserId,
        time: timestamp,
        senderemail: currentuseremail);

    List ids = [currentUserId, recieverId];
    ids.sort();
    String chatroomid = ids.join("_");
    await firestore
        .collection("chat_room")
        .doc(chatroomid)
        .collection("messages")
        .add(newmessage.toJson());
    await addMsgCount(recieverId, message, messagetype);
  }

  Future<void> addMsgCount(
      String receiverId, String message, String messageType) async {
    try {
      final String currentUserId = firebaseAuth.currentUser!.uid;
      List<String> ids = [currentUserId, receiverId];
      ids.sort();
      String chatRoomId = ids.join("_");

      final DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await firestore.collection("chat_room").doc(chatRoomId).get();
      final Timestamp timestamp = Timestamp.now();
      if (messageType == 'video') {
        message = 'Video';
      } else if (messageType == 'image') {
        message = 'Image';
      } else if (messageType == 'pdf') {
        message = 'PDF';
      } else if (messageType=='mp3'){
        message = 'Voice Message';
      }
      ReadUnReadModel unReadModel = ReadUnReadModel(
        senderId: currentUserId,
        recieverId: receiverId,
        msgNum: 0,
        lastMsg: message,
        time: timestamp,
      );

      if (docSnapshot.exists) {
        await firestore
            .collection("chat_room")
            .doc(chatRoomId)
            .update(unReadModel.toJson());
      } else {
        await firestore
            .collection("chat_room")
            .doc(chatRoomId)
            .set(unReadModel.toJson());
      }
    } catch (e) {
      print('Error updating message count: $e');
    }
  }

  Stream<ReadUnReadModel?> getUnreadMessageCountStream(String receiverId) {
    try {
      final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
      List<String> userIds = [currentUserId, receiverId];
      userIds.sort();
      String chatRoomId = userIds.join("_");
      return FirebaseFirestore.instance
          .collection("chat_room")
          .doc(chatRoomId)
          .snapshots()
          .map((snapshot) {
        if (snapshot.exists && snapshot.data()!.containsKey('msgNum')) {
          Map<String, dynamic> data = snapshot.data()!;
          return ReadUnReadModel(
              senderId: data['sender_id'],
              recieverId: data['receiver_id'],
              msgNum: data['msgNum'],
              lastMsg: data['last_msg'],
              time: data['time']);
        } else {
          return null;
        }
      });
    } catch (e) {
      print('Error getting unread message count: $e');
      return Stream.empty();
    }
  }

  clearUnreadMsg(String receiverId) async {
    final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    List<String> userIds = [currentUserId, receiverId];
    userIds.sort();
    String chatRoomId = userIds.join("_");
    await firestore.collection("chat_room").doc(chatRoomId).update({
      'msgNum': 0,
    });
  }

  Future<void> clearChat(String currentuserid, String recieverid) async {
    List ids = [currentuserid, recieverid];
    ids.sort();
    String chatroomid = ids.join("_");

    try {
      WriteBatch batch = firestore.batch();
      var snapshot = await firestore
          .collection("chat_room")
          .doc(chatroomid)
          .collection("messages")
          .get();

      var documents = snapshot.docs;
      for (DocumentSnapshot doc in documents) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } catch (e) {
      throw Exception(e);
    }
  }

  addImageMessage(String recieverid, image) async {
    Reference childfolder = storage.child('images');
    Reference? imageupload = childfolder.child("$recieverid.jpg");
    try {
      await imageupload.putFile(image);
      downloadurl = await imageupload.getDownloadURL();
      sendMessage(
        recieverid,
        downloadurl,
        "image",
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> selectAndSendVideo(File videoFile, String recipientId) async {
    try {
      final String videoUrl = await uploadVideoToStorage(videoFile);
      sendMessage(
        recipientId,
        videoUrl,
        "video",
      );
    } catch (e) {
      print('Error selecting and sending video: $e');
    }
  }

  Future<String> uploadVideoToStorage(File videoFile) async {
    try {
      final Reference storageRef = storage
          .child('videos')
          .child('${DateTime.now().millisecondsSinceEpoch}.mp4');
      final TaskSnapshot uploadTask = await storageRef.putFile(videoFile);
      final String videoUrl = await uploadTask.ref.getDownloadURL();
      return videoUrl;
    } catch (e) {
      print('Error uploading video to Firebase Storage: $e');
      rethrow;
    }
  }

  uploadPdf(String recieverId, String fileName, File file) async {
    final reference = storage.child("pdfs/$fileName.pdf");
    final uploadTask = reference.putFile(file);
    await uploadTask.whenComplete(() {});
    final downloadLink = await reference.getDownloadURL();
    sendMessage(
      recieverId,
      downloadLink,
      'pdf',
    );
    return downloadLink;
  }

  Future<String?> uploadAudio(String receiverId, String filePath) async {
    try {
      final file = File(filePath);
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('audio/${DateTime.now().millisecondsSinceEpoch}.mp3');
      final uploadTask = storageRef.putFile(file);
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      sendMessage(receiverId, downloadUrl, 'mp3');
      return downloadUrl;
    } catch (e) {
      print('Error uploading audio: $e');
      return null;
    }
  }
}
