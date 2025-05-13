import 'package:tracking_app/domain/entity/user_entity.dart';

/// _id : "680eb8861433a666c8d66efc"
/// firstName : "Elevate"
/// lastName : "Tech"
/// email : "omar@gmail.com"
/// gender : "male"
/// phone : "+201010700999"
/// photo : "default-profile.png"



class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,});

  User.fromJson(dynamic json) {
    id = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    gender = json['gender'];
    phone = json['phone'];
    photo = json['photo'];
  }
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? phone;
  String? photo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['gender'] = gender;
    map['phone'] = phone;
    map['photo'] = photo;
    return map;
  }
  UserEntity toUserEntity() {
    return UserEntity(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        gender: gender,
        phone: phone,
        photo: photo,
        );
  }

  factory User.fromEntity(UserEntity entity) {
    return User(
      firstName: entity.firstName,
      email: entity.email,
    );
  }
}