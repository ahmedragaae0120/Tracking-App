import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';

class applyrequest {
  final String country;
  final String firstName;
  final String rePassword;
  final String lastName;
  final String vehicleType;
  final String vehicleNumber;
  final File vehicleLicense;
  final String nid;
  final File nidImg;
  final String email;
  final String gender;
  final String phone;
  final String password;

  applyrequest({
    required this.country,
    required this.firstName,
    required this.rePassword,
    required this.lastName,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.vehicleLicense,
    required this.nid,
    required this.nidImg,
    required this.email,
    required this.gender,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    "country": country,
    "firstName": firstName,
    "lastName": lastName,
    "vehicleType": vehicleType,
    "vehicleNumber": vehicleNumber,
    "vehicleLicense": vehicleLicense,
    "NID": nid,
    "NIDImg": nidImg,
    "email": email,
    "gender": gender,
    "phone": phone,
    "password": password,
    "rePassword": rePassword
  };

  Future<FormData> toFormData() async {
    String getMimeType(File file) {
      String ext = extension(file.path).toLowerCase();
      switch (ext) {
        case '.jpg':
        case '.jpeg':
          return 'image/jpeg';
        case '.png':
          return 'image/png';
        case '.pdf':
          return 'application/pdf';
        default:
          throw Exception('Unsupported file type: \$ext');
      }
    }

    return FormData.fromMap({
      "country": country,
      "firstName": firstName,
      "lastName": lastName,
      "vehicleType": vehicleType,
      "vehicleNumber": vehicleNumber,
      "vehicleLicense": await MultipartFile.fromFile(
        vehicleLicense.path,
        contentType: MediaType.parse(getMimeType(vehicleLicense)),
        filename: basename(vehicleLicense.path),
      ),
      "NID": nid,
      "NIDImg": await MultipartFile.fromFile(
        nidImg.path,
        contentType: MediaType.parse(getMimeType(nidImg)),
        filename: basename(nidImg.path),
      ),
      "email": email,
      "gender": gender,
      "phone": phone,
      "password": password,
      "rePassword": rePassword,
    });
  }
}
