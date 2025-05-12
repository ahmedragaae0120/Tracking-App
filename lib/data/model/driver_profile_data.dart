/// message : "success"
/// driver : {"_id":"6818c00a1433a666c8d9b92f","country":"Egypt","firstName":"Ahmed","lastName":"Ali","vehicleType":"676b31a45d05310ca82657ac","vehicleNumber":"12221","vehicleLicense":"https://flower.elevateegy.com/uploads/dc3a22b6-4d4a-46bc-a36e-c6aa2569d47b-Screenshot_20250428_014711.png","NID":"12345678912345","NIDImg":"https://flower.elevateegy.com/uploads/fb18bfe0-5570-41e0-88e6-a1edf088e3ed-Screenshot_20250428_014711.png","email":"kareemhekal19@gmail.com","gender":"male","phone":"+201010700888","photo":"https://flower.elevateegy.com/uploads/default-profile.png","role":"driver","createdAt":"2025-05-05T13:41:30.112Z","passwordChangedAt":"2025-05-05T13:43:23.650Z"}

class DriverProfileData {
  DriverProfileData({
      this.message, 
      this.driver,});

  DriverProfileData.fromJson(dynamic json) {
    message = json['message'];
    driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
  }
  String? message;
  Driver? driver;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (driver != null) {
      map['driver'] = driver?.toJson();
    }
    return map;
  }

}

/// _id : "6818c00a1433a666c8d9b92f"
/// country : "Egypt"
/// firstName : "Ahmed"
/// lastName : "Ali"
/// vehicleType : "676b31a45d05310ca82657ac"
/// vehicleNumber : "12221"
/// vehicleLicense : "https://flower.elevateegy.com/uploads/dc3a22b6-4d4a-46bc-a36e-c6aa2569d47b-Screenshot_20250428_014711.png"
/// NID : "12345678912345"
/// NIDImg : "https://flower.elevateegy.com/uploads/fb18bfe0-5570-41e0-88e6-a1edf088e3ed-Screenshot_20250428_014711.png"
/// email : "kareemhekal19@gmail.com"
/// gender : "male"
/// phone : "+201010700888"
/// photo : "https://flower.elevateegy.com/uploads/default-profile.png"
/// role : "driver"
/// createdAt : "2025-05-05T13:41:30.112Z"
/// passwordChangedAt : "2025-05-05T13:43:23.650Z"

class Driver {
  Driver({
      this.id, 
      this.country, 
      this.firstName, 
      this.lastName, 
      this.vehicleType, 
      this.vehicleNumber, 
      this.vehicleLicense, 
      this.nid, 
      this.nIDImg, 
      this.email, 
      this.gender, 
      this.phone, 
      this.photo, 
      this.role, 
      this.createdAt, 
      this.passwordChangedAt,});

  Driver.fromJson(dynamic json) {
    id = json['_id'];
    country = json['country'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    vehicleType = json['vehicleType'];
    vehicleNumber = json['vehicleNumber'];
    vehicleLicense = json['vehicleLicense'];
    nid = json['NID'];
    nIDImg = json['NIDImg'];
    email = json['email'];
    gender = json['gender'];
    phone = json['phone'];
    photo = json['photo'];
    role = json['role'];
    createdAt = json['createdAt'];
    passwordChangedAt = json['passwordChangedAt'];
  }
  String? id;
  String? country;
  String? firstName;
  String? lastName;
  String? vehicleType;
  String? vehicleNumber;
  String? vehicleLicense;
  String? nid;
  String? nIDImg;
  String? email;
  String? gender;
  String? phone;
  String? photo;
  String? role;
  String? createdAt;
  String? passwordChangedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['country'] = country;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['vehicleType'] = vehicleType;
    map['vehicleNumber'] = vehicleNumber;
    map['vehicleLicense'] = vehicleLicense;
    map['NID'] = nid;
    map['NIDImg'] = nIDImg;
    map['email'] = email;
    map['gender'] = gender;
    map['phone'] = phone;
    map['photo'] = photo;
    map['role'] = role;
    map['createdAt'] = createdAt;
    map['passwordChangedAt'] = passwordChangedAt;
    return map;
  }

}