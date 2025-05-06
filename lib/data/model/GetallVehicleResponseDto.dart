import 'package:tracking_app/domain/entity/vehicle/getallvehicle_entity.dart';

class GetallVehicleResponseDto extends GetallvehicleEntity{
  GetallVehicleResponseDto({
      super.message,
      super.metadata,
      super.vehicles,});

  GetallVehicleResponseDto.fromJson(dynamic json) {
    message = json['message'];
    metadata = json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    if (json['vehicles'] != null) {
      vehicles = [];
      json['vehicles'].forEach((v) {
        vehicles?.add(Vehicles.fromJson(v));
      });
    }
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (metadata != null) {
      map['metadata'] = metadata;
    }
    if (vehicles != null) {
      map['vehicles'] = vehicles?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Vehicles extends VehiclesEntity {
  Vehicles({
    super.id,
    super.type,
    super.image,
    super.createdAt,
    super.updatedAt,
    super.v,});

  Vehicles.fromJson(dynamic json) {
    id = json['_id'];
    type = json['type'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }

Vehicles copyWith({  String? id,
  String? type,
  String? image,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => Vehicles(  id: id ?? this.id,
  type: type ?? this.type,
  image: image ?? this.image,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  v: v ?? this.v,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['type'] = type;
    map['image'] = image;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }

}

class Metadata extends MetadataVehicle {
  Metadata({
    super.currentPage,
    super.totalPages,
    super.limit,
    super.totalItems,});

  Metadata.fromJson(dynamic json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    limit = json['limit'];
    totalItems = json['totalItems'];
  }

Metadata copyWith({  num? currentPage,
  num? totalPages,
  num? limit,
  num? totalItems,
}) => Metadata(  currentPage: currentPage ?? this.currentPage,
  totalPages: totalPages ?? this.totalPages,
  limit: limit ?? this.limit,
  totalItems: totalItems ?? this.totalItems,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currentPage'] = currentPage;
    map['totalPages'] = totalPages;
    map['limit'] = limit;
    map['totalItems'] = totalItems;
    return map;
  }

}