import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? messagetype;
  String? content;
  String? senderId;
  String? senderemail;
  String? recieverId;
  Timestamp? time;

  MessageModel({
    this.content,
    this.messagetype,
    this.recieverId,
    this.senderId,
    this.time,
    this.senderemail,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messagetype: json["messagetype"],
      senderemail: json["senderemail"],
      content: json["content"],
      recieverId: json["recieverId"],
      senderId: json["senderId"],
      time: json["time"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "messagetype": messagetype,
      'senderemail': senderemail,
      "content": content,
      "recieverId": recieverId,
      "senderId": senderId,
      "time": time,
    };
  }
}
