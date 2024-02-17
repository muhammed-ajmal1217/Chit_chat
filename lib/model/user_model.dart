class UserModel{
  String? userName;
  String? email;
  String? userId;
  String? phoneNumber;
  UserModel({
    this.email,
    this.userId,
    this.userName,
    this.phoneNumber,
  });
 factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
      userName: json['name'],
      email: json['email'],
      userId: json['uid'],
      phoneNumber: json['phone'],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'name':userName,
      'email':email,
      'phone':phoneNumber,
    };
  }
}