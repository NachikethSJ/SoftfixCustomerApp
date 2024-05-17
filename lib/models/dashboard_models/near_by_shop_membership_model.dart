class NearByShopMembershipModel {
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
  List<Shop>? shop;
  List<dynamic>? image;
  Service? service;

  NearByShopMembershipModel(
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
        this.shop,
        this.image,
        this.service});

  NearByShopMembershipModel.fromJson(Map<String, dynamic> json) {
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
    if (json['shop'] != null) {
      shop = <Shop>[];
      json['shop'].forEach((v) {
        shop!.add(new Shop.fromJson(v));
      });
    }
    image = json['image'];
    service =
    json['service'] != null ? new Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shopId'] = this.shopId;
    data['membershipName'] = this.membershipName;
    data['serviceId'] = this.serviceId;
    data['subServiceId'] = this.subServiceId;
    data['userId'] = this.userId;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['price'] = this.price;
    data['serviceTypeId'] = this.serviceTypeId;
    data['offer'] = this.offer;
    data['details'] = this.details;
    data['termAndcondition'] = this.termAndcondition;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['mode'] = this.mode;
    data['noOfTimes'] = this.noOfTimes;
    data['isDelete'] = this.isDelete;
    data['file'] = this.file;
    data['status'] = this.status;
    if (this.shop != null) {
      data['shop'] = this.shop!.map((v) => v.toJson()).toList();
    }
    data['image'] = this.image;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    return data;
  }
}

class Shop {
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

  Shop(
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
        this.status});

  Shop.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shopId'] = this.shopId;
    data['membershipName'] = this.membershipName;
    data['serviceId'] = this.serviceId;
    data['subServiceId'] = this.subServiceId;
    data['userId'] = this.userId;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['price'] = this.price;
    data['serviceTypeId'] = this.serviceTypeId;
    data['offer'] = this.offer;
    data['details'] = this.details;
    data['termAndcondition'] = this.termAndcondition;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['mode'] = this.mode;
    data['noOfTimes'] = this.noOfTimes;
    data['isDelete'] = this.isDelete;
    data['file'] = this.file;
    data['status'] = this.status;
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
