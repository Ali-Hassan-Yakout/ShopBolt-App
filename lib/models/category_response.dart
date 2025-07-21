/// status : true
/// message : null
/// data : {"current_page":1,"data":[{"id":44,"name":"اجهزه الكترونيه","image":"https://student.valuxapps.com/storage/uploads/categories/16893929290QVM1.modern-devices-isometric-icons-collection-with-sixteen-isolated-images-computers-periphereals-variou.jpeg"},{"id":43,"name":"مكافحة كورونا","image":"https://student.valuxapps.com/storage/uploads/categories/1630142480dvQxx.3658058.jpg"},{"id":42,"name":"رياضة","image":"https://student.valuxapps.com/storage/uploads/categories/16445270619najK.6242655.jpg"},{"id":40,"name":"ادوات الاناره","image":"https://student.valuxapps.com/storage/uploads/categories/16445230161CiW8.Light bulb-amico.png"},{"id":46,"name":"ملابس","image":"https://student.valuxapps.com/storage/uploads/categories/1644527120pTGA7.clothes.png"}],"first_page_url":"https://student.valuxapps.com/api/categories?page=1","from":1,"last_page":1,"last_page_url":"https://student.valuxapps.com/api/categories?page=1","next_page_url":null,"path":"https://student.valuxapps.com/api/categories","per_page":35,"prev_page_url":null,"to":5,"total":5}

class CategoryResponse {
  CategoryResponse({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  CategoryResponse.fromJson(dynamic json) {
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

/// current_page : 1
/// data : [{"id":44,"name":"اجهزه الكترونيه","image":"https://student.valuxapps.com/storage/uploads/categories/16893929290QVM1.modern-devices-isometric-icons-collection-with-sixteen-isolated-images-computers-periphereals-variou.jpeg"},{"id":43,"name":"مكافحة كورونا","image":"https://student.valuxapps.com/storage/uploads/categories/1630142480dvQxx.3658058.jpg"},{"id":42,"name":"رياضة","image":"https://student.valuxapps.com/storage/uploads/categories/16445270619najK.6242655.jpg"},{"id":40,"name":"ادوات الاناره","image":"https://student.valuxapps.com/storage/uploads/categories/16445230161CiW8.Light bulb-amico.png"},{"id":46,"name":"ملابس","image":"https://student.valuxapps.com/storage/uploads/categories/1644527120pTGA7.clothes.png"}]
/// first_page_url : "https://student.valuxapps.com/api/categories?page=1"
/// from : 1
/// last_page : 1
/// last_page_url : "https://student.valuxapps.com/api/categories?page=1"
/// next_page_url : null
/// path : "https://student.valuxapps.com/api/categories"
/// per_page : 35
/// prev_page_url : null
/// to : 5
/// total : 5

class Data {
  Data({
    num? currentPage,
    List<DataListCategory>? data,
    String? firstPageUrl,
    num? from,
    num? lastPage,
    String? lastPageUrl,
    String? nextPageUrl,
    String? path,
    num? perPage,
    String? prevPageUrl,
    num? to,
    num? total,
  }) {
    _currentPage = currentPage;
    _data = data;
    _firstPageUrl = firstPageUrl;
    _from = from;
    _lastPage = lastPage;
    _lastPageUrl = lastPageUrl;
    _nextPageUrl = nextPageUrl;
    _path = path;
    _perPage = perPage;
    _prevPageUrl = prevPageUrl;
    _to = to;
    _total = total;
  }

  Data.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(DataListCategory.fromJson(v));
      });
    }
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _perPage = json['per_page'];
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }

  num? _currentPage;
  List<DataListCategory>? _data;
  String? _firstPageUrl;
  num? _from;
  num? _lastPage;
  String? _lastPageUrl;
  String? _nextPageUrl;
  String? _path;
  num? _perPage;
  String? _prevPageUrl;
  num? _to;
  num? _total;

  num get currentPage => _currentPage ?? -1;

  List<DataListCategory> get data => _data ?? [];

  String get firstPageUrl => _firstPageUrl ?? '';

  num get from => _from ?? -1;

  num get lastPage => _lastPage ?? -1;

  String get lastPageUrl => _lastPageUrl ?? '';

  String get nextPageUrl => _nextPageUrl ?? '';

  String get path => _path ?? '';

  num get perPage => _perPage ?? -1;

  String get prevPageUrl => _prevPageUrl ?? '';

  num get to => _to ?? -1;

  num get total => _total ?? -1;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = _firstPageUrl;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    map['last_page_url'] = _lastPageUrl;
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['prev_page_url'] = _prevPageUrl;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }
}

/// id : 44
/// name : "اجهزه الكترونيه"
/// image : "https://student.valuxapps.com/storage/uploads/categories/16893929290QVM1.modern-devices-isometric-icons-collection-with-sixteen-isolated-images-computers-periphereals-variou.jpeg"

class DataListCategory {
  DataListCategory({
    num? id,
    String? name,
    String? image,
  }) {
    _id = id;
    _name = name;
    _image = image;
  }

  DataListCategory.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
  }

  num? _id;
  String? _name;
  String? _image;

  num get id => _id ?? -1;

  String get name => _name ?? '';

  String get image => _image ?? '';

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    return map;
  }
}
