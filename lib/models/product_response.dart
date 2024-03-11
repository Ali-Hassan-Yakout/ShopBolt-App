/// status : true
/// message : null
/// data : {"id":52,"price":25000,"old_price":25000,"discount":0,"image":"https://student.valuxapps.com/storage/uploads/products/1615440322npwmU.71DVgBTdyLL._SL1500_.jpg","name":"Apple iPhone 12 Pro Max 256GB 6 GB RAM, Pacific Blue","description":"DISPLAY\r\nSize: 6.7 inches\r\nResolution: 2778 x 1284 pixels, 458 PPI\r\nTechnology: OLED\r\nScreen-to-body: 87.45 %\r\nPeak brightness: 1200 cd/m2 (nit)\r\nFeatures: HDR video support, Oleophobic coating, Scratch-resistant glass (Ceramic Shield), Ambient light sensor, Proximity sensor\r\nHARDWARE\r\nSystem chip: Apple A14 Bionic\r\nProcessor: Hexa-core, 64-bit, 5 nm\r\nGPU: Yes\r\nRAM: 6GB LPDDR5\r\nInternal storage: 128GB (NVMe), not expandable\r\nDevice type: Smartphone\r\nOS: iOS (14.x)\r\nBATTERY\r\nType: Li - Ion, Not user replaceable\r\nCharging: USB Power Delivery, Qi wireless charging, MagSafe wireless charging\r\nMax charge speed: Wireless: 15.0W\r\nCAMERA\r\nRear: Triple camera\r\nMain camera: 12 MP (OIS, PDAF)\r\nSpecifications: Aperture size: F1.6; Focal length: 26 mm; Pixel size: 1.7 μm\r\nSecond camera: 12 MP (Telephoto, OIS, PDAF)\r\nSpecifications: Optical zoom: 2x; Aperture size: F2.2; Focal Length: 65 mm\r\nThird camera: 12 MP (Ultra-wide)\r\nSpecifications: Aperture size: F2.4; Focal Length: 13 mm\r\nVideo recording: 3840x2160 (4K UHD) (60 fps), 1920x1080 (Full HD) (240 fps), 1280x720 (HD) (30 fps)\r\nFeatures: OIS, HDR, Time-lapse video, Continuous autofocus, Picture-taking during video recording, Video light\r\nFront: 12 MP (Time-of-Flight (ToF), EIS, HDR, Slow-motion videos)\r\nVideo capture: 3840x2160 (4K UHD) (60 fps)\r\nDESIGN\r\nDimensions: 6.33 x 3.07 x 0.29 inches (160.84 x 78.09 x 7.39 mm)\r\nWeight: 8.03 oz (228.0 g)\r\nMaterials: Back: Glass; Frame: Stainless steel\r\nMaterials & Colors: Pacific Blue\r\nResistance: Water, Splash, Dust; IP68\r\nBiometrics: 3D Face unlock\r\nKeys: Left: Volume control, Other; Right: Lock/Unlock key\r\nCELLULAR\r\n5G: n1, n2, n3, n5, n7, n8, n12, n20, n25, n28, n38, n40, n41, n66, n71, n77, n78, n79, n260, n261, Sub-6, mmWave\r\nLTE (FDD): Bands 1(2100), 2(1900), 3(1800), 4(AWS-1), 5(850), 7(2600), 8(900), 12(700 a), 13(700 c), 14(700 PS), 17(700 b), 18(800 Lower), 19(800 Upper), 20(800 DD), 25(1900+), 26(850+), 28(700 APT), 29(700 d), 30(2300 WCS), 32(1500 L-band), 66(AWS-3), 71(600)\r\nLTE (TDD): Bands 34(2000), 38(2600), 39(1900+), 40(2300), 41(2600+), 42(3500), 46, 48(3600)\r\nUMTS: 850, 900, 1700/2100, 1900, 2100 MHz\r\nData Speed: LTE-A, HSDPA+ (4G) 42.2 Mbit/s, HSUPA 5.76 Mbit/s, UMTS\r\nDual SIM: Yes\r\nSIM type: Nano SIM, eSIM\r\nHD Voice: Yes\r\nVoLTE: Yes\r\nMULTIMEDIA\r\nHeadphones: No 3.5mm jack\r\nSpeakers: Earpiece, Loudspeaker\r\nFeatures: Dolby Atmos\r\nScreen mirroring: Wireless screen share\r\nAdditional microphone(s): for Noise cancellation\r\nCONNECTIVITY & FEATURES\r\nBluetooth: 5.0\r\nWi-Fi: 802.11 a, b, g, n, ac, ax (Wi-Fi 6), dual-band; MIMO, Wi-Fi Direct, Hotspot\r\nUSB: Lightning\r\nFeatures: Charging, Headphones port\r\nLocation: GPS, A-GPS, Glonass, Galileo, BeiDou, QZSS, Cell ID, Wi-Fi positioning\r\nSensors: Accelerometer, Gyroscope, Compass, Barometer, LiDAR scanner\r\nOther: NFC, UMA (Wi-Fi Calling)\r\nHearing aid compatible: M3, T4\r\nBrand : Apple\r\nColor : Pacific Blue\r\nOperating System Type : iOS\r\nStorage Capacity : 128GB\r\nNumber Of SIM : Single SIM & E-SIM\r\nRear Camera Resolution : 12 megapixels\r\nMobile Phone Type : Mobile Phone\r\nCellular Network Technology : 5G\r\nChipset manufacturer : Apple\r\nDisplay Size (Inch) : 6.7 inches\r\nModel Number : iPhone 12 Pro Max\r\nBattery Capacity in mAh : 3,687mAh\r\nFast Charge : Yes\r\nMemory RAM : 6 GB","in_favorites":false,"in_cart":false,"images":["https://student.valuxapps.com/storage/uploads/products/1615440322UAwSF.81KcqNGQIsL._SL1500_.jpg","https://student.valuxapps.com/storage/uploads/products/1615440322UjY4o.71DVgBTdyLL._SL1500_.jpg"]}

class ProductResponse {
  ProductResponse({
    bool? status,
    String? message,
    DataProduct? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  ProductResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? DataProduct.fromJson(json['data']) : null;
  }

  bool? _status;
  String? _message;
  DataProduct? _data;

  bool get status => _status ?? false;

  String get message => _message ?? '';

  DataProduct get data => _data ?? DataProduct();

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

/// id : 52
/// price : 25000
/// old_price : 25000
/// discount : 0
/// image : "https://student.valuxapps.com/storage/uploads/products/1615440322npwmU.71DVgBTdyLL._SL1500_.jpg"
/// name : "Apple iPhone 12 Pro Max 256GB 6 GB RAM, Pacific Blue"
/// description : "DISPLAY\r\nSize: 6.7 inches\r\nResolution: 2778 x 1284 pixels, 458 PPI\r\nTechnology: OLED\r\nScreen-to-body: 87.45 %\r\nPeak brightness: 1200 cd/m2 (nit)\r\nFeatures: HDR video support, Oleophobic coating, Scratch-resistant glass (Ceramic Shield), Ambient light sensor, Proximity sensor\r\nHARDWARE\r\nSystem chip: Apple A14 Bionic\r\nProcessor: Hexa-core, 64-bit, 5 nm\r\nGPU: Yes\r\nRAM: 6GB LPDDR5\r\nInternal storage: 128GB (NVMe), not expandable\r\nDevice type: Smartphone\r\nOS: iOS (14.x)\r\nBATTERY\r\nType: Li - Ion, Not user replaceable\r\nCharging: USB Power Delivery, Qi wireless charging, MagSafe wireless charging\r\nMax charge speed: Wireless: 15.0W\r\nCAMERA\r\nRear: Triple camera\r\nMain camera: 12 MP (OIS, PDAF)\r\nSpecifications: Aperture size: F1.6; Focal length: 26 mm; Pixel size: 1.7 μm\r\nSecond camera: 12 MP (Telephoto, OIS, PDAF)\r\nSpecifications: Optical zoom: 2x; Aperture size: F2.2; Focal Length: 65 mm\r\nThird camera: 12 MP (Ultra-wide)\r\nSpecifications: Aperture size: F2.4; Focal Length: 13 mm\r\nVideo recording: 3840x2160 (4K UHD) (60 fps), 1920x1080 (Full HD) (240 fps), 1280x720 (HD) (30 fps)\r\nFeatures: OIS, HDR, Time-lapse video, Continuous autofocus, Picture-taking during video recording, Video light\r\nFront: 12 MP (Time-of-Flight (ToF), EIS, HDR, Slow-motion videos)\r\nVideo capture: 3840x2160 (4K UHD) (60 fps)\r\nDESIGN\r\nDimensions: 6.33 x 3.07 x 0.29 inches (160.84 x 78.09 x 7.39 mm)\r\nWeight: 8.03 oz (228.0 g)\r\nMaterials: Back: Glass; Frame: Stainless steel\r\nMaterials & Colors: Pacific Blue\r\nResistance: Water, Splash, Dust; IP68\r\nBiometrics: 3D Face unlock\r\nKeys: Left: Volume control, Other; Right: Lock/Unlock key\r\nCELLULAR\r\n5G: n1, n2, n3, n5, n7, n8, n12, n20, n25, n28, n38, n40, n41, n66, n71, n77, n78, n79, n260, n261, Sub-6, mmWave\r\nLTE (FDD): Bands 1(2100), 2(1900), 3(1800), 4(AWS-1), 5(850), 7(2600), 8(900), 12(700 a), 13(700 c), 14(700 PS), 17(700 b), 18(800 Lower), 19(800 Upper), 20(800 DD), 25(1900+), 26(850+), 28(700 APT), 29(700 d), 30(2300 WCS), 32(1500 L-band), 66(AWS-3), 71(600)\r\nLTE (TDD): Bands 34(2000), 38(2600), 39(1900+), 40(2300), 41(2600+), 42(3500), 46, 48(3600)\r\nUMTS: 850, 900, 1700/2100, 1900, 2100 MHz\r\nData Speed: LTE-A, HSDPA+ (4G) 42.2 Mbit/s, HSUPA 5.76 Mbit/s, UMTS\r\nDual SIM: Yes\r\nSIM type: Nano SIM, eSIM\r\nHD Voice: Yes\r\nVoLTE: Yes\r\nMULTIMEDIA\r\nHeadphones: No 3.5mm jack\r\nSpeakers: Earpiece, Loudspeaker\r\nFeatures: Dolby Atmos\r\nScreen mirroring: Wireless screen share\r\nAdditional microphone(s): for Noise cancellation\r\nCONNECTIVITY & FEATURES\r\nBluetooth: 5.0\r\nWi-Fi: 802.11 a, b, g, n, ac, ax (Wi-Fi 6), dual-band; MIMO, Wi-Fi Direct, Hotspot\r\nUSB: Lightning\r\nFeatures: Charging, Headphones port\r\nLocation: GPS, A-GPS, Glonass, Galileo, BeiDou, QZSS, Cell ID, Wi-Fi positioning\r\nSensors: Accelerometer, Gyroscope, Compass, Barometer, LiDAR scanner\r\nOther: NFC, UMA (Wi-Fi Calling)\r\nHearing aid compatible: M3, T4\r\nBrand : Apple\r\nColor : Pacific Blue\r\nOperating System Type : iOS\r\nStorage Capacity : 128GB\r\nNumber Of SIM : Single SIM & E-SIM\r\nRear Camera Resolution : 12 megapixels\r\nMobile Phone Type : Mobile Phone\r\nCellular Network Technology : 5G\r\nChipset manufacturer : Apple\r\nDisplay Size (Inch) : 6.7 inches\r\nModel Number : iPhone 12 Pro Max\r\nBattery Capacity in mAh : 3,687mAh\r\nFast Charge : Yes\r\nMemory RAM : 6 GB"
/// in_favorites : false
/// in_cart : false
/// images : ["https://student.valuxapps.com/storage/uploads/products/1615440322UAwSF.81KcqNGQIsL._SL1500_.jpg","https://student.valuxapps.com/storage/uploads/products/1615440322UjY4o.71DVgBTdyLL._SL1500_.jpg"]

class DataProduct {
  DataProduct({
    num? id,
    num? price,
    num? oldPrice,
    num? discount,
    String? image,
    String? name,
    String? description,
    bool? inFavorites,
    bool? inCart,
    List<String>? images,
  }) {
    _id = id;
    _price = price;
    _oldPrice = oldPrice;
    _discount = discount;
    _image = image;
    _name = name;
    _description = description;
    _inFavorites = inFavorites;
    _inCart = inCart;
    _images = images;
  }

  DataProduct.fromJson(dynamic json) {
    _id = json['id'];
    _price = json['price'];
    _oldPrice = json['old_price'];
    _discount = json['discount'];
    _image = json['image'];
    _name = json['name'];
    _description = json['description'];
    _inFavorites = json['in_favorites'];
    _inCart = json['in_cart'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
  }

  num? _id;
  num? _price;
  num? _oldPrice;
  num? _discount;
  String? _image;
  String? _name;
  String? _description;
  bool? _inFavorites;
  bool? _inCart;
  List<String>? _images;

  num get id => _id ?? -1;

  num get price => _price ?? -1;

  num get oldPrice => _oldPrice ?? -1;

  num get discount => _discount ?? -1;

  String get image => _image ?? '';

  String get name => _name ?? '';

  String get description => _description ?? '';

  bool get inFavorites => _inFavorites ?? false;

  bool get inCart => _inCart ?? false;

  List<String> get images => _images ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['price'] = _price;
    map['old_price'] = _oldPrice;
    map['discount'] = _discount;
    map['image'] = _image;
    map['name'] = _name;
    map['description'] = _description;
    map['in_favorites'] = _inFavorites;
    map['in_cart'] = _inCart;
    map['images'] = _images;
    return map;
  }
}
