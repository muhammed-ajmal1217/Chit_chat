import 'package:chitchat/model/story_view_mode.dart';

class UserModel{
  String? userName;
  String? email;
  String? userId;
  String? recieverName;
  String? receiverId;
  String? phoneNumber;
  String? profilePicture;
  bool? isRequested;
  bool? isPending;
  bool? isAccepted;
  UserModel({
    this.email,
    this.userId,
    this.userName,
    this.phoneNumber,
    this.profilePicture,
    this.recieverName,
    this.receiverId,
    this.isRequested,
    this.isPending,
    this.isAccepted,
  });
 factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
      userName: json['name'],
      email: json['email'],
      userId: json['userid'],
      phoneNumber: json['phone'],
      profilePicture: json['profile_picture'],
      recieverName: json['receiver_name'],
      receiverId: json['receiver_id'],
      isRequested: json['is_requested'],
      isAccepted: json['is_accepted'],
      isPending: json['is_pending'],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'name':userName,
      'email':email,
      'phone':phoneNumber,
      'userid':userId,
      'profile_picture':profilePicture,
      'receiver_name':recieverName,
      'receiver_id':receiverId,
      'is_requested':isRequested,
      'is_accepted':isAccepted,
      'is_pending':isPending,

    };
  }
}