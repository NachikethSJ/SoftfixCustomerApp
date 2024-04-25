class GetMemberShipDetailsModel {
  Membership? membership;
  List<String>? imageUrl;
  ServiceDetail? serviceDetail;
  SubServiceDetail? subServiceDetail;

  GetMemberShipDetailsModel(
      {this.membership,
        this.imageUrl,
        this.serviceDetail,
        this.subServiceDetail});

  GetMemberShipDetailsModel.fromJson(Map<String, dynamic> json) {
    membership = json['membership'] != null
        ? new Membership.fromJson(json['membership'])
        : null;
    imageUrl = json['imageUrl'].cast<String>();
    serviceDetail = json['serviceDetail'] != null
        ? new ServiceDetail.fromJson(json['serviceDetail'])
        : null;
    subServiceDetail = json['subServiceDetail'] != null
        ? new SubServiceDetail.fromJson(json['subServiceDetail'])
        : null;
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
    return data;
  }
}

class Membership {
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
