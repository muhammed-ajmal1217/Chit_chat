class FriendAcceptModel{
  String? friendName;
  String? friendId;

  FriendAcceptModel({
    this.friendName,
    this.friendId,
  });
  factory FriendAcceptModel.fromJson(Map<String,dynamic>json){
    return FriendAcceptModel(
      friendId: json['friend_id'],
      friendName: json['friend_name'],
    );
  }
  Map<String,dynamic> toJson(){
    return {
      'friend_id':friendId,
      'friend_name':friendName,
    };
  }

}