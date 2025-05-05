/// message : "success"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkcml2ZXIiOiI2ODE4YzAwYTE0MzNhNjY2YzhkOWI5MmYiLCJpYXQiOjE3NDY0NTI2MTZ9.m3jc-glYORl5O1jG26srQjOBGmZQHwQNB14LYmw50KE"

class UserModel {
  UserModel({
    this.message,
    this.token,});

  UserModel.fromJson(dynamic json) {
    message = json['message'];
    token = json['token'];
  }
  String? message;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['token'] = token;
    return map;
  }

}