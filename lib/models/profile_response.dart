/// status : true
/// message : null
/// data : {"id":60539,"name":"Ali Hassan Yakout","email":"ali@instant.com","phone":"0101515","image":"https://student.valuxapps.com/storage/assets/defaults/user.jpg","points":401279,"credit":100319.715000000011059455573558807373046875,"token":"JUOWY8NBEk3RIMcRx25sNL7IwyGbHM7TXRpU2Cd76qWipEYtgmF6aq3mNBxfB2xje07fQx"}

class ProfileResponse {
  ProfileResponse({
    bool? status,
    String? message,
    DataProfile? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  ProfileResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? DataProfile.fromJson(json['data']) : null;
  }

  bool? _status;
  String? _message;
  DataProfile? _data;

  bool get status => _status ?? false;

  String get message => _message ?? '';

  DataProfile get data => _data ?? DataProfile();

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

/// id : 60539
/// name : "Ali Hassan Yakout"
/// email : "ali@instant.com"
/// phone : "0101515"
/// image : "https://student.valuxapps.com/storage/assets/defaults/user.jpg"
/// points : 401279
/// credit : 100319.715000000011059455573558807373046875
/// token : "JUOWY8NBEk3RIMcRx25sNL7IwyGbHM7TXRpU2Cd76qWipEYtgmF6aq3mNBxfB2xje07fQx"

class DataProfile {
  DataProfile({
    num? id,
    String? name,
    String? email,
    String? phone,
    String? image,
    num? points,
    num? credit,
    String? token,
  }) {
    _id = id;
    _name = name;
    _email = email;
    _phone = phone;
    _image = image;
    _points = points;
    _credit = credit;
    _token = token;
  }

  DataProfile.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _image = json['image'];
    _points = json['points'];
    _credit = json['credit'];
    _token = json['token'];
  }

  num? _id;
  String? _name;
  String? _email;
  String? _phone;
  String? _image;
  num? _points;
  num? _credit;
  String? _token;

  num get id => _id ?? -1;

  String get name => _name ?? '';

  String get email => _email ?? '';

  String get phone => _phone ?? '';

  String get image => _image ?? '';

  num get points => _points ?? -1;

  num get credit => _credit ?? -1;

  String get token => _token ?? '';

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['phone'] = _phone;
    map['image'] = _image;
    map['points'] = _points;
    map['credit'] = _credit;
    map['token'] = _token;
    return map;
  }
}
