/// name : "Elevate FlowerApp Store"
/// image : "https://www.elevateegy.com/elevate.png"
/// address : "123 Fixed Address, City, Country"
/// phoneNumber : "1234567890"
/// latLong : "37.7749,-122.4194"

class Store {
  Store({
    this.name,
    this.image,
    this.address,
    this.phoneNumber,
    this.latLong,});

  Store.fromJson(dynamic json) {
    name = json['name'];
    image = json['image'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    latLong = json['latLong'];
  }
  String? name;
  String? image;
  String? address;
  String? phoneNumber;
  String? latLong;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['image'] = image;
    map['address'] = address;
    map['phoneNumber'] = phoneNumber;
    map['latLong'] = latLong;
    return map;
  }

}
