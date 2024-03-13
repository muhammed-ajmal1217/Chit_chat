class ReadUnReadModel{
  int? fromMessages;
  int? toMessages;
  String? senderId;
  String? recieverId;
  String? lastMsg;
  ReadUnReadModel({
    this.fromMessages,
    this.toMessages,
    this.senderId,
    this.recieverId,
    this.lastMsg,
  });
  factory ReadUnReadModel.fromJson(Map<String,dynamic>json){
    return ReadUnReadModel(
      fromMessages: json['from_msg'],
      toMessages: json['to_msg'],
      senderId: json['sender_id'],
      recieverId: json['reciever_id'],
      lastMsg: json['last_msg'],
    );
  }
  Map<String,dynamic> toJson(){
    return {
      'from_msg':fromMessages,
      'to_msg':toMessages,
      'sender_id':senderId,
      'reciever_id':recieverId,
      'last_msg':lastMsg,
    };
  }
}