import 'package:spotifake/domain/entities/auth/user.dart';

class UserModel {
  
  String? fullName;
  String? email;
  String? imgUrl;

  UserModel({
    this.fullName,
    this.email,
    this.imgUrl,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    fullName = json['name'];
    email = json['email'];
    imgUrl = json['imgUrl'];
  }
  
}

extension UserModelExtension on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      fullName: fullName,
      email: email,
      imgUrl: imgUrl,
    );
  }
}