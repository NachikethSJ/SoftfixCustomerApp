class SearchByShopServicesModel {
  List<ServiceResult>? serviceResult;
  List<ShopPackages>? shopPackages;
  List<ShopMemberships>? shopMemberships;

  SearchByShopServicesModel(
      {this.serviceResult, this.shopPackages, this.shopMemberships});

  SearchByShopServicesModel.fromJson(Map<String, dynamic> json) {
    if (json['serviceResult'] != null) {
      serviceResult = <ServiceResult>[];
      json['serviceResult'].forEach((v) {
        serviceResult!.add(new ServiceResult.fromJson(v));
      });
    }
    if (json['shopPackages'] != null) {
      shopPackages = <ShopPackages>[];
      json['shopPackages'].forEach((v) {
        shopPackages!.add(new ShopPackages.fromJson(v));
      });
    }
    if (json['shopMemberships'] != null) {
      shopMemberships = <ShopMemberships>[];
      json['shopMemberships'].forEach((v) {
        shopMemberships!.add(new ShopMemberships.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.serviceResult != null) {
      data['serviceResult'] =
          this.serviceResult!.map((v) => v.toJson()).toList();
    }
    if (this.shopPackages != null) {
      data['shopPackages'] = this.shopPackages!.map((v) => v.toJson()).toList();
    }
    if (this.shopMemberships != null) {
      data['shopMemberships'] =
          this.shopMemberships!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceResult {
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

  ServiceResult(
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

  ServiceResult.fromJson(Map<String, dynamic> json) {
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

class ShopPackages {
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
  String? serviceTypeId;

  ShopPackages(
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
        this.serviceTypeId});

  ShopPackages.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class ShopMemberships {
  int? id;
  String? shopId;
  String? membershipName;
  String? serviceId;
  String? subServiceId;
  int? userId;
  String? startDate;
  String? endDate;
  int? price;
  String? serviceTypeId;
  int? offer;
  String? details;
  String? termAndcondition;
  String? createdBy;
  dynamic updatedBy;
  String? createdAt;
  dynamic updatedAt;
  dynamic mode;
  int? noOfTimes;
  int? isDelete;
  String? file;
  int? status;

  ShopMemberships(
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

  ShopMemberships.fromJson(Map<String, dynamic> json) {
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
