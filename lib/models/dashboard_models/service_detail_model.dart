class GetServiceDetailsModel {
  Service? service;
  dynamic imageUrl;
  ShopDetail? shopDetail;

  GetServiceDetailsModel({this.service, this.imageUrl, this.shopDetail});

  GetServiceDetailsModel.fromJson(Map<String, dynamic> json) {
    service =
    json['service'] != null ? new Service.fromJson(json['service']) : null;
    imageUrl = json['imageUrl'];
    shopDetail = json['shopDetail'] != null
        ? new ShopDetail.fromJson(json['shopDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    data['imageUrl'] = this.imageUrl;
    if (this.shopDetail != null) {
      data['shopDetail'] = this.shopDetail!.toJson();
    }
    return data;
  }
}

class Service {
  dynamic id;
  String? name;
  dynamic shopId;
  String? userId;
  String? createdBy;
  dynamic updatedBy;
  String? createdAt;
  dynamic updatedAt;
  dynamic isDelete;
  dynamic mode;
  String? serviceTypeId;
  dynamic status;

  Service(
      {this.id,
        this.name,
        this.shopId,
        this.userId,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.isDelete,
        this.mode,
        this.serviceTypeId,
        this.status});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shopId = json['shopId'];
    userId = json['userId'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDelete = json['IsDelete'];
    mode = json['mode'];
    serviceTypeId = json['serviceTypeId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['shopId'] = this.shopId;
    data['userId'] = this.userId;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['IsDelete'] = this.isDelete;
    data['mode'] = this.mode;
    data['serviceTypeId'] = this.serviceTypeId;
    data['status'] = this.status;
    return data;
  }
}

class ShopDetail {
  dynamic id;
  String? branchId;
  String? name;
  String? mobile;
  double? lat;
  double? lng;
  String? description;
  String? gstNo;
  String? tinNo;
  String? panNo;
  String? aadhaar;
  String? address;
  String? pin;
  String? file;
  String? country;
  String? state;
  String? city;
  String? status;
  dynamic token;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  dynamic updatedAt;
  dynamic isDelete;
  dynamic review;
  String? comment;
  String? percentage;
  dynamic otp;
  dynamic otpTime;
  String? vendorId;
  String? shopId;

  ShopDetail(
      {this.id,
        this.branchId,
        this.name,
        this.mobile,
        this.lat,
        this.lng,
        this.description,
        this.gstNo,
        this.tinNo,
        this.panNo,
        this.aadhaar,
        this.address,
        this.pin,
        this.file,
        this.country,
        this.state,
        this.city,
        this.status,
        this.token,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.isDelete,
        this.review,
        this.comment,
        this.percentage,
        this.otp,
        this.otpTime,
        this.vendorId,
        this.shopId});

  ShopDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchId = json['branchId'];
    name = json['name'];
    mobile = json['mobile'];
    lat = json['lat'];
    lng = json['lng'];
    description = json['description'];
    gstNo = json['gstNo'];
    tinNo = json['tinNo'];
    panNo = json['panNo'];
    aadhaar = json['aadhaar'];
    address = json['address'];
    pin = json['pin'];
    file = json['file'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    status = json['status'];
    token = json['token'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDelete = json['IsDelete'];
    review = json['review'];
    comment = json['comment'];
    percentage = json['percentage'];
    otp = json['otp'];
    otpTime = json['otpTime'];
    vendorId = json['vendorId'];
    shopId = json['shopId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branchId'] = this.branchId;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['description'] = this.description;
    data['gstNo'] = this.gstNo;
    data['tinNo'] = this.tinNo;
    data['panNo'] = this.panNo;
    data['aadhaar'] = this.aadhaar;
    data['address'] = this.address;
    data['pin'] = this.pin;
    data['file'] = this.file;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['status'] = this.status;
    data['token'] = this.token;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['IsDelete'] = this.isDelete;
    data['review'] = this.review;
    data['comment'] = this.comment;
    data['percentage'] = this.percentage;
    data['otp'] = this.otp;
    data['otpTime'] = this.otpTime;
    data['vendorId'] = this.vendorId;
    data['shopId'] = this.shopId;
    return data;
  }
}
