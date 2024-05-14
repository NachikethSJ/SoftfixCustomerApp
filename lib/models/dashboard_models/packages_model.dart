class PackagesModel {
  int? id;
  int? userId;
  String? packageName;
  String? startDate;
  String? endDate;
  int? price;
  String? details;
  String? termAndcondition;
  String? createdBy;
  dynamic updatedBy;
  String? createdAt;
  dynamic updatedAt;
  dynamic mode;
  String? shopId;
  String? serviceId;
  int? discount;
  String? file;
  int? isDelete;
  int? status;
  dynamic serviceTypeId;
  int? totalServiceTime;
  Shop? shop;
  List<Service>? service;
  List<dynamic>? image;

  PackagesModel(
      {this.id,
        this.userId,
        this.packageName,
        this.startDate,
        this.endDate,
        this.price,
        this.details,
        this.termAndcondition,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.mode,
        this.shopId,
        this.serviceId,
        this.discount,
        this.file,
        this.isDelete,
        this.status,
        this.serviceTypeId,
        this.totalServiceTime,
        this.shop,
        this.service,
        this.image});

  PackagesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    packageName = json['packageName'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    price = json['price'];
    details = json['details'];
    termAndcondition = json['termAndcondition'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mode = json['mode'];
    shopId = json['shopId'];
    serviceId = json['serviceId'];
    discount = json['discount'];
    file = json['file'];
    isDelete = json['isDelete'];
    status = json['status'];
    serviceTypeId = json['serviceTypeId'];
    totalServiceTime = json['totalServiceTime'];
    shop = json['shop'] != null ? new Shop.fromJson(json['shop']) : null;
    if (json['service'] != null) {
      service = <Service>[];
      json['service'].forEach((v) {
        service!.add(new Service.fromJson(v));
      });
    }
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['packageName'] = this.packageName;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['price'] = this.price;
    data['details'] = this.details;
    data['termAndcondition'] = this.termAndcondition;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['mode'] = this.mode;
    data['shopId'] = this.shopId;
    data['serviceId'] = this.serviceId;
    data['discount'] = this.discount;
    data['file'] = this.file;
    data['isDelete'] = this.isDelete;
    data['status'] = this.status;
    data['serviceTypeId'] = this.serviceTypeId;
    data['totalServiceTime'] = this.totalServiceTime;
    if (this.shop != null) {
      data['shop'] = this.shop!.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service!.map((v) => v.toJson()).toList();
    }
    data['image'] = this.image;
    return data;
  }
}

class Shop {
  int? id;
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
  int? isDelete;
  dynamic review;
  dynamic comment;
  dynamic percentage;
  dynamic otp;
  dynamic otpTime;
  String? vendorId;
  String? shopId;

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
        this.shopId});

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

class Service {
  int? id;
  String? name;
  int? shopId;
  String? userId;
  String? createdBy;
  dynamic updatedBy;
  String? createdAt;
  dynamic updatedAt;
  int? isDelete;
  dynamic mode;
  String? serviceTypeId;
  int? status;
  List<SubServices>? subServices;

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
        this.status,
        this.subServices});

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
    if (json['SubServices'] != null) {
      subServices = <SubServices>[];
      json['SubServices'].forEach((v) {
        subServices!.add(new SubServices.fromJson(v));
      });
    }
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
    if (this.subServices != null) {
      data['SubServices'] = this.subServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubServices {
  int? id;
  int? serviceId;
  int? userId;
  String? type;
  int? price;
  int? timeTaken;
  String? offer;
  String? details;
  int? persontype;
  String? termAndcondition;
  int? file;
  String? createdBy;
  dynamic updatedBy;
  String? createdAt;
  dynamic updatedAt;
  int? isDelete;
  dynamic rating;
  int? status;
  dynamic comment;
  int? adminStatus;

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
        this.adminStatus});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serviceId'] = this.serviceId;
    data['userId'] = this.userId;
    data['type'] = this.type;
    data['price'] = this.price;
    data['timeTaken'] = this.timeTaken;
    data['offer'] = this.offer;
    data['details'] = this.details;
    data['persontype'] = this.persontype;
    data['termAndcondition'] = this.termAndcondition;
    data['file'] = this.file;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['IsDelete'] = this.isDelete;
    data['rating'] = this.rating;
    data['status'] = this.status;
    data['comment'] = this.comment;
    data['adminStatus'] = this.adminStatus;
    return data;
  }
}
