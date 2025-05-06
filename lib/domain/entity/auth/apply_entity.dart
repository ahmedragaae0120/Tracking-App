class ApplyEntity {
  ApplyEntity({
      this.message, 
      this.driver, 
      this.token,});


  String? message;
  DriverEntity? driver;
  String? token;
ApplyEntity copyWith({  String? message,
  DriverEntity? driver,
  String? token,
}) => ApplyEntity(  message: message ?? this.message,
  driver: driver ?? this.driver,
  token: token ?? this.token,
);


}

class DriverEntity {
  DriverEntity({
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
      this.id, 
      this.createdAt,});


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
  String? id;
  String? createdAt;
DriverEntity copyWith({  String? country,
  String? firstName,
  String? lastName,
  String? vehicleType,
  String? vehicleNumber,
  String? vehicleLicense,
  String? nid,
  String? nIDImg,
  String? email,
  String? gender,
  String? phone,
  String? photo,
  String? role,
  String? id,
  String? createdAt,
}) => DriverEntity(  country: country ?? this.country,
  firstName: firstName ?? this.firstName,
  lastName: lastName ?? this.lastName,
  vehicleType: vehicleType ?? this.vehicleType,
  vehicleNumber: vehicleNumber ?? this.vehicleNumber,
  vehicleLicense: vehicleLicense ?? this.vehicleLicense,
  nid: nid ?? this.nid,
  nIDImg: nIDImg ?? this.nIDImg,
  email: email ?? this.email,
  gender: gender ?? this.gender,
  phone: phone ?? this.phone,
  photo: photo ?? this.photo,
  role: role ?? this.role,
  id: id ?? this.id,
  createdAt: createdAt ?? this.createdAt,
);


}