class NearByShopPackagesModel {
  Package? package;
  Service? service;
  List<SubServices>? subServices;

  NearByShopPackagesModel({this.package, this.service, this.subServices});

  NearByShopPackagesModel.fromJson(Map<String, dynamic> json) {
    package =
    json['package'] != null ? new Package.fromJson(json['package']) : null;
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
  List<dynamic>? imageUrl;

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
        this.serviceTypeId,
        this.imageUrl});

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
