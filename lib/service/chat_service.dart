import 'package:chitchat/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Reference storage=FirebaseStorage.instance.ref();

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


}
