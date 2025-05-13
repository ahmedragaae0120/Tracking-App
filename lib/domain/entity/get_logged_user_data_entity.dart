import 'package:tracking_app/domain/entity/user_entity.dart';

/// message : "success"
/// user : {"_id":"67dfe0e1836ee8be7062578c","firstName":"Mariam","lastName":"Shahir","email":"mariamshahir2000@gmail.com","gender":"female","phone":"+201554195222","GetLoggedUserDataModel":"https://flower.elevateegy.com/uploads/default-profile.png","role":"user","wishlist":[],"addresses":[],"createdAt":"2025-03-23T10:22:25.485Z"}

class GetLoggedUserDataEntity {
  String? message;
  UserEntity? user;

  GetLoggedUserDataEntity({this.message, this.user});
}
