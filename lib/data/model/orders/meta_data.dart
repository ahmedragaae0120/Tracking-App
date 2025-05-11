
/// currentPage : 1
/// totalPages : 8
/// totalItems : 78
/// limit : 10


class Metadata {
  Metadata({
    this.currentPage,
    this.totalPages,
    this.totalItems,
    this.limit,});

  Metadata.fromJson(dynamic json) {
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    totalItems = json['totalItems'];
    limit = json['limit'];
  }
  num? currentPage;
  num? totalPages;
  num? totalItems;
  num? limit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currentPage'] = currentPage;
    map['totalPages'] = totalPages;
    map['totalItems'] = totalItems;
    map['limit'] = limit;
    return map;
  }

}
