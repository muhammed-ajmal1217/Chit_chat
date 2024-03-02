class RequestModel {
  String? recieverId; 
  String? recieverName;
  String? senderId;
  String? senderName;

  RequestModel({
    this.recieverId, 
    this.senderId,
    this.senderName,
    this.recieverName,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      recieverId: json['reciever_id'], 
      senderId: json['sender_id'],
      senderName: json['sender_name'],
      recieverName: json['reciever_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reciever_id': recieverId, 
      'sender_id': senderId,
      'sender_name': senderName,
      'reciever_name': recieverName,
    };
  }
}
