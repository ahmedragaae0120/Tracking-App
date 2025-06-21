import 'dart:io';

import 'package:dio/dio.dart';

class UpdateVehicleRequest {
  final String vehicleId;
  final File licenseFile;

  UpdateVehicleRequest({
    required this.vehicleId,
    required this.licenseFile,
  });

  /// لتحويل البيانات إلى `FormData` لرفع صورة
  FormData toFormData() {
    return FormData.fromMap({
      'name': vehicleId,
      'image': MultipartFile.fromFileSync(
        licenseFile.path,
        filename: licenseFile.path.split('/').last,
      ),
    });
  }
}
