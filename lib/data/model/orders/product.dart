/// _id : "673e308c115992017182816d"
/// title : "Moko Chocolate Set | Esperance Rose"
/// slug : "moko-chocolate-set-or-esperance-rose"
/// description : "Indulge in the ultimate chocolate experience with the Moko Chocolate Bundle! This delightful assortment features the Moko Cranberry White Chocolate Dragee and three irresistible 41% Milk Chocolate Bars Crunchy Hazelnut, Salted Caramel, and Crunchy Pistachio Praline. Perfect for satisfying your sweet cravings or as a thoughtful gift for someone special. Enjoy premium flavors and quality with every bite. Don’t wait treat yourself or a loved one to this delectable chocolate bundle. Buy now and make every moment sweeter!"
/// imgCover : "aa6c2099-17db-4e81-85eb-2314cdaf31e8-cover_image.png"
/// images : ["081c1a80-67ae-4c5a-962b-894c9d32f6db-image_four.png","3a44160e-3a56-4aa5-91ae-b54ceb752f7d-image_one.png","c55c2f05-5d64-4086-b0be-3b383cee3fef-image_three.png","8b2708f3-4384-475e-b4e0-e7368b2a6e2f-image_two.png"]
/// price : 1200
/// priceAfterDiscount : 900
/// quantity : 33279
/// category : "673c479e1159920171827c99"
/// occasion : "673b39241159920171827b28"
/// createdAt : "2024-11-20T18:55:08.188Z"
/// updatedAt : "2025-05-08T15:33:41.100Z"
/// __v : 0
/// discount : 50
/// sold : 1055

// ignore_for_file: dangling_library_doc_comments

class Product {
  Product({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.discount,
    this.sold,
  });

  Product.fromJson(dynamic json) {
    id = json['_id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    imgCover = json['imgCover'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    price = json['price'];
    priceAfterDiscount = json['priceAfterDiscount'];
    quantity = json['quantity'];
    category = json['category'];
    occasion = json['occasion'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    discount = json['discount'];
    sold = json['sold'];
  }
  String? id;
  String? title;
  String? slug;
  String? description;
  String? imgCover;
  List<String>? images;
  num? price;
  num? priceAfterDiscount;
  num? quantity;
  String? category;
  String? occasion;
  String? createdAt;
  String? updatedAt;
  num? v;
  num? discount;
  num? sold;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['title'] = title;
    map['slug'] = slug;
    map['description'] = description;
    map['imgCover'] = imgCover;
    map['images'] = images;
    map['price'] = price;
    map['priceAfterDiscount'] = priceAfterDiscount;
    map['quantity'] = quantity;
    map['category'] = category;
    map['occasion'] = occasion;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['discount'] = discount;
    map['sold'] = sold;
    return map;
  }
}
