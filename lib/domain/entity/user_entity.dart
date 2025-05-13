/// firstName : "Mariam"
/// lastName : "Shahir"
/// email : "mariamshahir2000@gmail.com"
/// gender : "female"
/// phone : "+201554195222"
/// photo : "default-profile.png"
/// _id : "67af710586a024f06ea26a31"
/// username : "ehabsalah"
/// firstName : "ehab"
/// lastName : "salah"
/// email : "ehabsalah@gmail.com"
/// phone : "01143668719"
/// role : "user"
/// wishlist : []
/// _id : "67dfe0e1836ee8be7062578c"
/// addresses : []
/// createdAt : "2025-03-23T10:22:25.485Z"
/// isVerified : false
/// createdAt : "2025-02-14T16:36:21.143Z"

// ignore_for_file: dangling_library_doc_comments

class UserEntity {
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? phone;
  String? photo;
  String? role;
  List<dynamic>? wishlist;
  String? id;
  List<dynamic>? addresses;
  String? createdAt;
  String? username;

  UserEntity({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.wishlist,
    this.addresses,
    this.createdAt,
  });
}
