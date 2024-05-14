class NearByShopServicesModel {
  Shop? shop;
  Service? service;
  List<SubServices>? subServices;

  NearByShopServicesModel({this.shop, this.service, this.subServices});

  NearByShopServicesModel.fromJson(Map<String, dynamic> json) {
    shop = json['shop'] != null ? new Shop.fromJson(json['shop']) : null;
    service =
    json['service'] != null ? new Service.fromJson(json['service']) : null;
    if (json['subServices'] != null) {
      subServices = <SubServices>[];
      json['subServices'].forEach((v) {
        subServices!.add(new SubServices.fromJson(v));
      });
    }
  }

}

class Shop {
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
  dynamic createdBy;
  dynamic updatedBy;
  String? createdAt;
  dynamic updatedAt;
  dynamic isDelete;
  dynamic review;
  dynamic comment;
  dynamic percentage;
  dynamic otp;
  dynamic otpTime;
  String? vendorId;
  String? shopId;
  List<dynamic>? imageUrl;

  Shop(
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
        this.shopId,
        this.imageUrl});

  Shop.fromJson(Map<String, dynamic> json) {
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
    imageUrl = json['imageUrl'];
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

}

class SubServices {
  dynamic id;
  dynamic serviceId;
  dynamic userId;
  String? type;
  dynamic price;
  dynamic timeTaken;
  String? offer;
  String? details;
  dynamic persontype;
  String? termAndcondition;
  dynamic file;
  String? createdBy;
  dynamic updatedBy;
  String? createdAt;
  dynamic updatedAt;
  dynamic isDelete;
  dynamic rating;
  dynamic status;
  dynamic comment;
  dynamic adminStatus;
  List<dynamic>? imageurl;

  SubServices(
      {this.id,
        this.serviceId,
        this.userId,
        this.type,
        this.price,
        this.timeTaken,
        this.offer,
        this.details,
        this.persontype,
        this.termAndcondition,
        this.file,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.isDelete,
        this.rating,
        this.status,
        this.comment,
        this.adminStatus,
        this.imageurl});

  SubServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['serviceId'];
    userId = json['userId'];
    type = json['type'];
    price = json['price'];
    timeTaken = json['timeTaken'];
    offer = json['offer'];
    details = json['details'];
    persontype = json['persontype'];
    termAndcondition = json['termAndcondition'];
    file = json['file'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDelete = json['IsDelete'];
    rating = json['rating'];
    status = json['status'];
    comment = json['comment'];
    adminStatus = json['adminStatus'];
    imageurl = json['imageurl'];
  }

}
