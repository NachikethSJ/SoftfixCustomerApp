class GetMemberShipDetailsModel {
  Membership? membership;
  List<dynamic>? imageUrl;
  ServiceDetail? serviceDetail;
  SubServiceDetail? subServiceDetail;
  String? shopName;
  List<dynamic>? shopImageUrl;

  GetMemberShipDetailsModel(
      {this.membership,
        this.imageUrl,
        this.serviceDetail,
        this.subServiceDetail,
        this.shopName,
        this.shopImageUrl});

  GetMemberShipDetailsModel.fromJson(Map<String, dynamic> json) {
    membership = json['membership'] != null
        ? new Membership.fromJson(json['membership'])
        : null;
    imageUrl = json['imageUrl'];
    serviceDetail = json['serviceDetail'] != null
        ? new ServiceDetail.fromJson(json['serviceDetail'])
        : null;
    subServiceDetail = json['subServiceDetail'] != null
        ? new SubServiceDetail.fromJson(json['subServiceDetail'])
        : null;
    shopName = json['shopName'];
    shopImageUrl = json['shopImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.membership != null) {
      data['membership'] = this.membership!.toJson();
    }
    data['imageUrl'] = this.imageUrl;
    if (this.serviceDetail != null) {
      data['serviceDetail'] = this.serviceDetail!.toJson();
    }
    if (this.subServiceDetail != null) {
      data['subServiceDetail'] = this.subServiceDetail!.toJson();
    }
    data['shopName'] = this.shopName;
    data['shopImageUrl'] = this.shopImageUrl;
    return data;
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
        this.status});

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
  dynamic status;

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
        this.status});

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

class SubServiceDetail {
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

  SubServiceDetail(
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

  SubServiceDetail.fromJson(Map<String, dynamic> json) {
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
