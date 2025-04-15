class absenModel {
  String? message;
  int? statusCode;
  Data? data;
  List<Data>? listdata;

  absenModel({this.message, this.data});

  absenModel.fromJson(Map<String, dynamic> json, int? status) {
    message = json['message'];
    statusCode = status;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  absenModel.fromListJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      listdata = <Data>[];
      json['data'].forEach((v) {
        listdata!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? checkIn;
  String? checkInLocation;
  String? checkInAddress;
  String? checkOut;
  String? checkOutLocation;
  String? checkOutAddress;
  String? status;
  String? alasanIzin;
  String? createdAt;
  String? updatedAt;
  double? checkInLat;
  double? checkInLng;
  double? checkOutLat;
  double? checkOutLng;

  Data({
    this.id,
    this.userId,
    this.checkIn,
    this.checkInLocation,
    this.checkInAddress,
    this.checkOut,
    this.checkOutLocation,
    this.checkOutAddress,
    this.status,
    this.alasanIzin,
    this.createdAt,
    this.updatedAt,
    this.checkInLat,
    this.checkInLng,
    this.checkOutLat,
    this.checkOutLng,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    checkIn = json['check_in'];
    checkInLocation = json['check_in_location'];
    checkInAddress = json['check_in_address'];
    checkOut = json['check_out'];
    checkOutLocation = json['check_out_location'];
    checkOutAddress = json['check_out_address'];
    status = json['status'];
    alasanIzin = json['alasan_izin'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    checkInLat = json['check_in_lat'];
    checkInLng = json['check_in_lng'];
    checkOutLat = json['check_out_lat'];
    checkOutLng = json['check_out_lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['check_in'] = this.checkIn;
    data['check_in_location'] = this.checkInLocation;
    data['check_in_address'] = this.checkInAddress;
    data['check_out'] = this.checkOut;
    data['check_out_location'] = this.checkOutLocation;
    data['check_out_address'] = this.checkOutAddress;
    data['status'] = this.status;
    data['alasan_izin'] = this.alasanIzin;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['check_in_lat'] = this.checkInLat;
    data['check_in_lng'] = this.checkInLng;
    data['check_out_lat'] = this.checkOutLat;
    data['check_out_lng'] = this.checkOutLng;
    return data;
  }
}
