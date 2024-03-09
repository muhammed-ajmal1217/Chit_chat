class UserModel{
  String? userName;
  String? email;
  String? userId;
  String? phoneNumber;
  String? profilePicture;
  UserModel({
    this.email,
    this.userId,
    this.userName,
    this.phoneNumber,
    this.profilePicture,
  });
 factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
      userName: json['name'],
      email: json['email'],
      userId: json['userid'],
      phoneNumber: json['phone'],
      profilePicture: json['profile_picture']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'name':userName,
      'email':email,
      'phone':phoneNumber,
      'userid':userId,
      'profile_picture':profilePicture,
    };
  }
}