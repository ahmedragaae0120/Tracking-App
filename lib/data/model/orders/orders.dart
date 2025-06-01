// import 'package:tracking_app/data/model/orders/store.dart';
// import 'package:tracking_app/data/model/orders/user.dart';
//
// import 'order_items.dart';
//
// /// _id : "68150be41433a666c8d91c6c"
// /// user : {"_id":"680eb8861433a666c8d66efc","firstName":"Elevate","lastName":"Tech","email":"omar@gmail.com","gender":"male","phone":"+201010700999","photo":"default-profile.png"}
// /// orderItems : [{"product":{"_id":"673e308c115992017182816d","title":"Moko Chocolate Set | Esperance Rose","slug":"moko-chocolate-set-or-esperance-rose","description":"Indulge in the ultimate chocolate experience with the Moko Chocolate Bundle! This delightful assortment features the Moko Cranberry White Chocolate Dragee and three irresistible 41% Milk Chocolate Bars Crunchy Hazelnut, Salted Caramel, and Crunchy Pistachio Praline. Perfect for satisfying your sweet cravings or as a thoughtful gift for someone special. Enjoy premium flavors and quality with every bite. Don’t wait treat yourself or a loved one to this delectable chocolate bundle. Buy now and make every moment sweeter!","imgCover":"aa6c2099-17db-4e81-85eb-2314cdaf31e8-cover_image.png","images":["081c1a80-67ae-4c5a-962b-894c9d32f6db-image_four.png","3a44160e-3a56-4aa5-91ae-b54ceb752f7d-image_one.png","c55c2f05-5d64-4086-b0be-3b383cee3fef-image_three.png","8b2708f3-4384-475e-b4e0-e7368b2a6e2f-image_two.png"],"price":1200,"priceAfterDiscount":900,"quantity":33279,"category":"673c479e1159920171827c99","occasion":"673b39241159920171827b28","createdAt":"2024-11-20T18:55:08.188Z","updatedAt":"2025-05-08T15:33:41.100Z","__v":0,"discount":50,"sold":1055},"price":1200,"quantity":3,"_id":"68150bd61433a666c8d91c34"}]
// /// totalPrice : 1800
// /// paymentType : "cash"
// /// isPaid : false
// /// isDelivered : false
// /// state : "pending"
// /// createdAt : "2025-05-02T18:16:04.804Z"
// /// updatedAt : "2025-05-02T18:16:04.804Z"
// /// orderNumber : "#124722"
// /// __v : 0
// /// store : {"name":"Elevate FlowerApp Store","image":"https://www.elevateegy.com/elevate.png","address":"123 Fixed Address, City, Country","phoneNumber":"1234567890","latLong":"37.7749,-122.4194"}
//
// class Orders {
//   Orders({
//     this.id,
//     this.user,
//     this.orderItems,
//     this.totalPrice,
//     this.paymentType,
//     this.isPaid,
//     this.isDelivered,
//     this.state,
//     this.createdAt,
//     this.updatedAt,
//     this.orderNumber,
//     this.v,
//     this.store,});
//
//   Orders.fromJson(dynamic json) {
//     id = json['_id'];
//     user = json['user'] != null ? User.fromJson(json['user']) : null;
//     if (json['orderItems'] != null) {
//       orderItems = [];
//       json['orderItems'].forEach((v) {
//         orderItems?.add(OrderItems.fromJson(v));
//       });
//     }
//     totalPrice = json['totalPrice'];
//     paymentType = json['paymentType'];
//     isPaid = json['isPaid'];
//     isDelivered = json['isDelivered'];
//     state = json['state'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     orderNumber = json['orderNumber'];
//     v = json['__v'];
//     store = json['store'] != null ? Store.fromJson(json['store']) : null;
//   }
//   String? id;
//   User? user;
//   List<OrderItems>? orderItems;
//   num? totalPrice;
//   String? paymentType;
//   bool? isPaid;
//   bool? isDelivered;
//   String? state;
//   String? createdAt;
//   String? updatedAt;
//   String? orderNumber;
//   num? v;
//   Store? store;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['_id'] = id;
//     if (user != null) {
//       map['user'] = user?.toJson();
//     }
//     if (orderItems != null) {
//       map['orderItems'] = orderItems?.map((v) => v.toJson()).toList();
//     }
//     map['totalPrice'] = totalPrice;
//     map['paymentType'] = paymentType;
//     map['isPaid'] = isPaid;
//     map['isDelivered'] = isDelivered;
//     map['state'] = state;
//     map['createdAt'] = createdAt;
//     map['updatedAt'] = updatedAt;
//     map['orderNumber'] = orderNumber;
//     map['__v'] = v;
//     if (store != null) {
//       map['store'] = store?.toJson();
//     }
//     return map;
//   }
//
// }

import 'driver_order.dart';
import 'order_items.dart';

class Orders {
  Orders({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
    this.store,
  });

  Orders.fromJson(dynamic json) {
    id = json['_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['orderItems'] != null) {
      orderItems = [];
      json['orderItems'].forEach((v) {
        orderItems?.add(OrderItems.fromJson(v));
      });
    }
    totalPrice = (json['totalPrice'] != null) ? (json['totalPrice'] as num) : null;
    paymentType = json['paymentType'];
    isPaid = json['isPaid'];
    isDelivered = json['isDelivered'];
    state = json['state'];

    // تحويل String to DateTime مع null safety
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];

    orderNumber = json['orderNumber'];
    v = json['__v'];
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
  }

  String? id;
  User? user;
  List<OrderItems>? orderItems;
  num? totalPrice;
  String? paymentType;
  bool? isPaid;
  bool? isDelivered;
  String? state;
  String? createdAt;  // بدل String؟ الى DateTime؟
  String? updatedAt;  // بدل String؟ الى DateTime؟
  String? orderNumber;
  num? v;
  Store? store;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (user != null) {
      map['user'] = user!.toJson();
    }
    if (orderItems != null) {
      map['orderItems'] = orderItems!.map((v) => v.toJson()).toList();
    }
    map['totalPrice'] = totalPrice;
    map['paymentType'] = paymentType;
    map['isPaid'] = isPaid;
    map['isDelivered'] = isDelivered;
    map['state'] = state;

    // تحويل DateTime to String مع null safety
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;

    map['orderNumber'] = orderNumber;
    map['__v'] = v;
    if (store != null) {
      map['store'] = store!.toJson();
    }
    return map;
  }
}
