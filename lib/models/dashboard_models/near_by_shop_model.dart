class NearByShopModel {
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
  List<Services>? services;
  List<Package>? package;
  List<Membership>? membership;
  String? countryName;
  String? stateName;
  String? cityName;
  String? branchName;
  List<String>? imageUrl;

  NearByShopModel(
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
        this.services,
        this.package,
        this.membership,
        this.countryName,
        this.stateName,
        this.cityName,
        this.branchName,
        this.imageUrl});

  NearByShopModel.fromJson(Map<String, dynamic> json) {
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
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(Services.fromJson(v));
      });
    }
    if (json['package'] != null) {
      package = <Package>[];
      json['package'].forEach((v) {
        package!.add(Package.fromJson(v));
      });
    }
    if (json['membership'] != null) {
      membership = <Membership>[];
      json['membership'].forEach((v) {
        membership!.add(Membership.fromJson(v));
      });
    }
    countryName = json['countryName'];
    stateName = json['stateName'];
    cityName = json['cityName'];
    branchName = json['branchName'];
    imageUrl = json['imageUrl'].cast<String>();
  }

}

class Services {
  dynamic id;
  String? name;
  dynamic shopId;
  String? userId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  dynamic isDelete;
  dynamic mode;
  String? serviceTypeId;
  List<SubServices>? subService;

  Services(
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
        this.subService});

  Services.fromJson(Map<String, dynamic> json) {
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
    if (json['subService'] != null) {
      subService = <SubServices>[];
      json['subService'].forEach((v) {
        subService!.add(SubServices.fromJson(v));
      });
    }
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
        this.comment});

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
  }

}

class Package {
  dynamic id;
  dynamic userId;
  String? packageName;
  String? startDate;
  String? endDate;
  dynamic price;
  String? details;
  String? termAndcondition;
  String? createdBy;
  dynamic updatedBy;
  String? createdAt;
  dynamic updatedAt;
  dynamic mode;
  String? shopId;
  List<ServiceId>? serviceId;
  dynamic discount;
  String? file;
  dynamic isDelete;
  dynamic status;
  List<String>? image;
  List<ServiceDetail>? serviceDetail;

  Package(
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
        this.image,
        this.serviceDetail});

  Package.fromJson(Map<String, dynamic> json) {
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
    if (json['serviceId'] != null) {
      serviceId = <ServiceId>[];
      json['serviceId'].forEach((v) {
        serviceId!.add(ServiceId.fromJson(v));
      });
    }
    discount = json['discount'];
    file = json['file'];
    isDelete = json['isDelete'];
    status = json['status'];
    image = json['image'].cast<String>();
    if (json['serviceDetail'] != null) {
      serviceDetail = <ServiceDetail>[];
      json['serviceDetail'].forEach((v) {
        serviceDetail!.add(ServiceDetail.fromJson(v));
      });
    }
  }

}

class ServiceId {
  dynamic id;
  String? subServiceId;

  ServiceId({this.id, this.subServiceId});

  ServiceId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subServiceId = json['subServiceId'];
  }


}

class ServiceDetail {
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
  SubServices? subService;

  ServiceDetail(
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
        this.subService});

  ServiceDetail.fromJson(Map<String, dynamic> json) {
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
    subService = json['subService'] != null
        ? SubServices.fromJson(json['subService'])
        : null;
  }

}

class Membership {
  dynamic id;
  String? shopId;
  String? membershipName;
  String? serviceId;
  String? subServiceId;
  dynamic userId;
  String? startDate;
  String? endDate;
  dynamic price;
  String? serviceTypeId;
  dynamic offer;
  String? details;
  String? termAndcondition;
  String? createdBy;
  dynamic updatedBy;
  String? createdAt;
  dynamic updatedAt;
  dynamic mode;
  dynamic noOfTimes;
  dynamic isDelete;
  String? file;
  dynamic status;
  List<String>? image;
  ServiceDetail? service;

  Membership(
      {this.id,
        this.shopId,
        this.membershipName,
        this.serviceId,
        this.subServiceId,
        this.userId,
        this.startDate,
        this.endDate,
        this.price,
        this.serviceTypeId,
        this.offer,
        this.details,
        this.termAndcondition,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.mode,
        this.noOfTimes,
        this.isDelete,
        this.file,
        this.status,
        this.image,
        this.service});

  Membership.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopId = json['shopId'];
    membershipName = json['membershipName'];
    serviceId = json['serviceId'];
    subServiceId = json['subServiceId'];
    userId = json['userId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    price = json['price'];
    serviceTypeId = json['serviceTypeId'];
    offer = json['offer'];
    details = json['details'];
    termAndcondition = json['termAndcondition'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mode = json['mode'];
    noOfTimes = json['noOfTimes'];
    isDelete = json['isDelete'];
    file = json['file'];
    status = json['status'];
    image = json['image'].cast<String>();
    service = json['service'] != null
        ? ServiceDetail.fromJson(json['service'])
        : null;
  }

}
