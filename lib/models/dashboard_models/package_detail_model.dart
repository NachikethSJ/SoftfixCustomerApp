class GetPackageDetailsModel {
  Package? package;
  List<dynamic>? imageUrl;
  String? shopName;
  List<ServiceIdData>? serviceIdData;

  GetPackageDetailsModel(
      {this.package, this.imageUrl, this.shopName, this.serviceIdData});

  GetPackageDetailsModel.fromJson(Map<String, dynamic> json) {
    package =
    json['package'] != null ? new Package.fromJson(json['package']) : null;
    imageUrl = json['imageUrl'];
    shopName = json['shopName'];
    if (json['serviceIdData'] != null) {
      serviceIdData = <ServiceIdData>[];
      json['serviceIdData'].forEach((v) {
        serviceIdData!.add(new ServiceIdData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.package != null) {
      data['package'] = this.package!.toJson();
    }
    data['imageUrl'] = this.imageUrl;
    data['shopName'] = this.shopName;
    if (this.serviceIdData != null) {
      data['serviceIdData'] =
          this.serviceIdData!.map((v) => v.toJson()).toList();
    }
    return data;
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
  String? serviceId;
  dynamic discount;
  String? file;
  dynamic isDelete;
  dynamic status;
  String? serviceTypeId;

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
        this.serviceTypeId});

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

class ServiceIdData {
  ServiceName? serviceName;
  List<SubserviceName>? subserviceName;

  ServiceIdData({this.serviceName, this.subserviceName});

  ServiceIdData.fromJson(Map<String, dynamic> json) {
    serviceName = json['serviceName'] != null
        ? new ServiceName.fromJson(json['serviceName'])
        : null;
    if (json['subserviceName'] != null) {
      subserviceName = <SubserviceName>[];
      json['subserviceName'].forEach((v) {
        subserviceName!.add(new SubserviceName.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.serviceName != null) {
      data['serviceName'] = this.serviceName!.toJson();
    }
    if (this.subserviceName != null) {
      data['subserviceName'] =
          this.subserviceName!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceName {
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

  ServiceName(
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

  ServiceName.fromJson(Map<String, dynamic> json) {
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

class SubserviceName {
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

  SubserviceName(
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

  SubserviceName.fromJson(Map<String, dynamic> json) {
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
