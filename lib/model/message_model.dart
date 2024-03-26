import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? messagetype;
  String? content;
  String? senderId;
  String? senderemail;
  String? recieverId;
  Timestamp? time;
  String? audioUrl;
  String?location;

  MessageModel({
    this.content,
    this.messagetype,
    this.recieverId,
    this.senderId,
    this.time,
    this.senderemail,
    this.audioUrl,
    this.location
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messagetype: json["messagetype"],
      senderemail: json["senderemail"],
      content: json["content"],
      recieverId: json["recieverId"],
      senderId: json["senderId"],
      time: json["time"],
      audioUrl: json["audioUrl"],
      location: json["location"],
      
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
      "audioUrl": audioUrl,
      "location": location,
       
    };
  }
}
