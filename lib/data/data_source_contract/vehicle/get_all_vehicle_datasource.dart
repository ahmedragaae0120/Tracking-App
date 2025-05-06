import 'package:tracking_app/domain/common/result.dart';
import 'package:tracking_app/domain/entity/vehicle/getallvehicle_entity.dart';

abstract class getallvehicledatasourceContract{
  Future<Result<GetallvehicleEntity>>get();

}