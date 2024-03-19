import 'package:cloud_firestore/cloud_firestore.dart';

class ReadUnReadModel{
  int? msgNum;
  String? senderId;
  String? recieverId;
  String? lastMsg;
  Timestamp? time;
  ReadUnReadModel({
    this.msgNum,
    this.senderId,
    this.recieverId,
    this.lastMsg,
    this.time
    
  });
  factory ReadUnReadModel.fromJson(Map<String,dynamic>json){
    return ReadUnReadModel(
      msgNum: json['msgNum'],
      senderId: json['sender_id'],
      recieverId: json['reciever_id'],
      lastMsg: json['last_msg'],
      time: json['time'],
    );
  }
  Map<String,dynamic> toJson(){
    return {
      'msgNum':msgNum,
      'sender_id':senderId,
      'reciever_id':recieverId,
      'last_msg':lastMsg,
      'time':time,
    };
  }
}