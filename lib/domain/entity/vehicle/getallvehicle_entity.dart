class GetallvehicleEntity {
  GetallvehicleEntity({
      this.message, 
      this.metadata, 
      this.vehicles,});


  String? message;
  MetadataVehicle? metadata;
  List<VehiclesEntity>? vehicles;
GetallvehicleEntity copyWith({  String? message,
  MetadataVehicle? metadata,
  List<VehiclesEntity>? vehicles,
}) => GetallvehicleEntity(  message: message ?? this.message,
  metadata: metadata ?? this.metadata,
  vehicles: vehicles ?? this.vehicles,
);


}

class VehiclesEntity {
  VehiclesEntity({
      this.id, 
      this.type, 
      this.image, 
      this.createdAt, 
      this.updatedAt, 
      this.v,});


  String? id;
  String? type;
  String? image;
  String? createdAt;
  String? updatedAt;
  num? v;
VehiclesEntity copyWith({  String? id,
  String? type,
  String? image,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => VehiclesEntity(  id: id ?? this.id,
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

class MetadataVehicle {
  MetadataVehicle({
      this.currentPage, 
      this.totalPages, 
      this.limit, 
      this.totalItems,});

  MetadataVehicle.fromJson(dynamic json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    limit = json['limit'];
    totalItems = json['totalItems'];
  }
  num? currentPage;
  num? totalPages;
  num? limit;
  num? totalItems;
MetadataVehicle copyWith({  num? currentPage,
  num? totalPages,
  num? limit,
  num? totalItems,
}) => MetadataVehicle(  currentPage: currentPage ?? this.currentPage,
  totalPages: totalPages ?? this.totalPages,
  limit: limit ?? this.limit,
  totalItems: totalItems ?? this.totalItems,
);


}