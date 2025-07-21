/// status : true
/// message : "تم التسجيل بنجاح"
/// data : {"name":"Ali Hassan","email":"ail@instant1.com","phone":"010151569","id":60554,"image":"https://student.valuxapps.com/storage/assets/defaults/user.jpg","token":"VQY9lITULxTpBK5qgUSgI1NhiGXKmWf3oeYnLGtU0PCXOFCyTRz2rG11fU0UbFggIc12OQ"}

class RegisterResponse {
  RegisterResponse({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  RegisterResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? _status;
  String? _message;
  Data? _data;

  bool get status => _status ?? false;

  String get message => _message ?? '';

  Data get data => _data ?? Data();

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// name : "Ali Hassan"
/// email : "ail@instant1.com"
/// phone : "010151569"
/// id : 60554
/// image : "https://student.valuxapps.com/storage/assets/defaults/user.jpg"
/// token : "VQY9lITULxTpBK5qgUSgI1NhiGXKmWf3oeYnLGtU0PCXOFCyTRz2rG11fU0UbFggIc12OQ"

class Data {
  Data({
    String? name,
    String? email,
    String? phone,
    num? id,
    String? image,
    String? token,
  }) {
    _name = name;
    _email = email;
    _phone = phone;
    _id = id;
    _image = image;
    _token = token;
  }

  Data.fromJson(dynamic json) {
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _id = json['id'];
    _image = json['image'];
    _token = json['token'];
  }

  String? _name;
  String? _email;
  String? _phone;
  num? _id;
  String? _image;
  String? _token;

  String get name => _name ?? '';

  String get email => _email ?? '';

  String get phone => _phone ?? '';

  num get id => _id ?? -1;

  String get image => _image ?? '';

  String get token => _token ?? '';

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['email'] = _email;
    map['phone'] = _phone;
    map['id'] = _id;
    map['image'] = _image;
    map['token'] = _token;
    return map;
  }
}
