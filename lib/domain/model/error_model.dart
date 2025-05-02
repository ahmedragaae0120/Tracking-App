/// message : "fail"
/// errors : {"value":"ahmedmfmslf1gmail.com","msg":"Invalid email ","param":"email","location":"body"}

class ErrorModel {
  ErrorModel({
    this.message,
    this.errors,
  });

  String? message;
  List<ErrorData>? errors; // ✅ تغيير errors إلى List

  ErrorModel.fromJson(dynamic json) {
    message = json['message'];

    // ✅ التأكد من أن errors هي قائمة
    if (json['errors'] != null) {
      if (json['errors'] is List) {
        errors =
            (json['errors'] as List).map((e) => ErrorData.fromJson(e)).toList();
      } else if (json['errors'] is Map) {
        errors = [ErrorData.fromJson(json['errors'])];
      }
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;

    if (errors != null) {
      map['errors'] = errors?.map((e) => e.toJson()).toList();
    }

    return map;
  }
}

// class ErrorModel {
//   ErrorModel({
//     this.message,
//     this.errors,
//   });

//   ErrorModel.fromJson(dynamic json) {
//     message = json['message'];
//     errors = json['errors'] != null ? ErrorData.fromJson(json['errors']) : null;
//   }
//   String? message;
//   ErrorData? errors;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['message'] = message;
//     if (errors != null) {
//       map['errors'] = errors?.toJson();
//     }
//     return map;
//   }
// }

/// value : "ahmedmfmslf1gmail.com"
/// msg : "Invalid email "
/// param : "email"
/// location : "body"

class ErrorData {
  ErrorData({
    this.value,
    this.msg,
    this.param,
    this.location,
  });

  ErrorData.fromJson(dynamic json) {
    value = json['value'];
    msg = json['msg'];
    param = json['param'];
    location = json['location'];
  }
  String? value;
  String? msg;
  String? param;
  String? location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = value;
    map['msg'] = msg;
    map['param'] = param;
    map['location'] = location;
    return map;
  }
}
