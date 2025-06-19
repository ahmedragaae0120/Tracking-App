

import 'package:tracking_app/data/model/orders/orders.dart';

class DriverOrder {
  final String id;
  final String driver;
  final Orders order;
  final int v;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Store store;

  DriverOrder({
    required this.id,
    required this.driver,
    required this.order,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
    required this.store,
  });

  factory DriverOrder.fromJson(Map<String, dynamic> json) {
    return DriverOrder(
      id: json["_id"] ?? '',
      driver: json["driver"] ?? '',
      order: json["order"] != null ? Orders.fromJson(json["order"]) : throw Exception("Order data missing"),
      v: json["__v"] ?? 0,
      createdAt: DateTime.tryParse(json["createdAt"] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? '') ?? DateTime.now(),
      store: json["store"] != null ? Store.fromJson(json["store"]) : throw Exception("Store data missing"),
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "driver": driver,
    "order": order.toJson(),
    "__v": v,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "store": store.toJson(),
  };
}


// class DriverOrder {
//   final String id;
//   final String driver;
//   final Orders order;
//   final int v;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final Store store;
//
//   DriverOrder({
//     required this.id,
//     required this.driver,
//     required this.order,
//     required this.v,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.store,
//   });
//
//   factory DriverOrder.fromJson(Map<String, dynamic> json) => DriverOrder(
//     id: json["_id"],
//     driver: json["driver"],
//     order: Orders.fromJson(json["order"]),
//     v: json["__v"],
//     createdAt: DateTime.parse(json["createdAt"]),
//     updatedAt: DateTime.parse(json["updatedAt"]),
//     store: Store.fromJson(json["store"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "driver": driver,
//     "order": order.toJson(),
//     "__v": v,
//     "createdAt": createdAt.toIso8601String(),
//     "updatedAt": updatedAt.toIso8601String(),
//     "store": store.toJson(),
//   };
// }

// class Orders {
//   final String id;
//   final User user;
//   final List<OrderItem> orderItems;
//   final double totalPrice;
//   final String paymentType;
//   final bool isPaid;
//   final bool isDelivered;
//   final String state;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final String orderNumber;
//   final int v;
//
//   Orders({
//     required this.id,
//     required this.user,
//     required this.orderItems,
//     required this.totalPrice,
//     required this.paymentType,
//     required this.isPaid,
//     required this.isDelivered,
//     required this.state,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.orderNumber,
//     required this.v,
//   });
//
//   factory Orders.fromJson(Map<String, dynamic> json) => Orders(
//     id: json["_id"],
//     user: User.fromJson(json["user"]),
//     orderItems: List<OrderItem>.from(
//         json["orderItems"].map((x) => OrderItem.fromJson(x))),
//     totalPrice: (json["totalPrice"] as num).toDouble(),
//     paymentType: json["paymentType"],
//     isPaid: json["isPaid"],
//     isDelivered: json["isDelivered"],
//     state: json["state"],
//     createdAt: DateTime.parse(json["createdAt"]),
//     updatedAt: DateTime.parse(json["updatedAt"]),
//     orderNumber: json["orderNumber"],
//     v: json["__v"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "user": user.toJson(),
//     "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
//     "totalPrice": totalPrice,
//     "paymentType": paymentType,
//     "isPaid": isPaid,
//     "isDelivered": isDelivered,
//     "state": state,
//     "createdAt": createdAt.toIso8601String(),
//     "updatedAt": updatedAt.toIso8601String(),
//     "orderNumber": orderNumber,
//     "__v": v,
//   };
// }

class User {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final String? phone;
  final String? photo;
  final String? passwordResetCode;
  final DateTime? passwordResetExpires;
  final bool? resetCodeVerified;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.passwordResetCode,
    this.passwordResetExpires,
    this.resetCodeVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      phone: json['phone'] as String?,
      photo: json['photo'] as String?,
      passwordResetCode: json['passwordResetCode'] as String?,
      passwordResetExpires: json['passwordResetExpires'] != null
          ? DateTime.tryParse(json['passwordResetExpires'])
          : null,
      resetCodeVerified: json['resetCodeVerified'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "gender": gender,
    "phone": phone,
    "photo": photo,
    "passwordResetCode": passwordResetCode,
    "passwordResetExpires": passwordResetExpires?.toIso8601String(),
    "resetCodeVerified": resetCodeVerified,
  };

}

class OrderItem {
  final Products product;
  final double price;
  final int quantity;
  final String id;

  OrderItem({
    required this.product,
    required this.price,
    required this.quantity,
    required this.id,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    product: Products.fromJson(json["product"]),
    price: (json["price"] as num).toDouble(),
    quantity: json["quantity"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "product": product.toJson(),
    "price": price,
    "quantity": quantity,
    "_id": id,
  };
}

class Products {
  final String id;
  final double price;

  Products({
    required this.id,
    required this.price,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    id: json["_id"],
    price: (json["price"] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "price": price,
  };
}

class Store {
  final String name;
  final String image;
  final String address;
  final String phoneNumber;
  final String latLong;

  Store({
    required this.name,
    required this.image,
    required this.address,
    required this.phoneNumber,
    required this.latLong,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    name: json["name"],
    image: json["image"],
    address: json["address"],
    phoneNumber: json["phoneNumber"],
    latLong: json["latLong"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "address": address,
    "phoneNumber": phoneNumber,
    "latLong": latLong,
  };
}
