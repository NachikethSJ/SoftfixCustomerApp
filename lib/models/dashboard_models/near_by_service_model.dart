class NearServiceModel {
  dynamic shopId;
  String? branchId;
  String? shopName;
  String? mobile;
  dynamic lat;
  dynamic lng;
  String? address;
  String? pin;
  List<dynamic>? image;
  String? country;
  String? state;
  String? city;
  String? vendorId;
  dynamic serviceId;
  String? serviceName;
  dynamic userId;
  String? serviceTypeId;
  List<SubService>? subService;

  NearServiceModel(
      {this.shopId,
        this.branchId,
        this.shopName,
        this.mobile,
        this.lat,
        this.lng,
        this.address,
        this.pin,
        this.image,
        this.country,
        this.state,
        this.city,
        this.vendorId,
        this.serviceId,
        this.serviceName,
        this.userId,
        this.serviceTypeId,
        this.subService});

  NearServiceModel.fromJson(Map<String, dynamic> json) {
    shopId = json['shopId'];
    branchId = json['branchId'];
    shopName = json['shopName'];
    mobile = json['mobile'];
    lat = json['lat'];
    lng = json['lng'];
    address = json['address'];
    pin = json['pin'];
    image = json['image'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    vendorId = json['vendorId'];
    serviceId = json['serviceId'];
    serviceName = json['serviceName'];
    userId = json['userId'];
    serviceTypeId = json['serviceTypeId'];
    if (json['SubService'] != null) {
      subService = <SubService>[];
      json['SubService'].forEach((v) {
        subService!.add(new SubService.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shopId'] = this.shopId;
    data['branchId'] = this.branchId;
    data['shopName'] = this.shopName;
    data['mobile'] = this.mobile;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['address'] = this.address;
    data['pin'] = this.pin;
    data['image'] = this.image;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['vendorId'] = this.vendorId;
    data['serviceId'] = this.serviceId;
    data['serviceName'] = this.serviceName;
    data['userId'] = this.userId;
    data['serviceTypeId'] = this.serviceTypeId;
    if (this.subService != null) {
      data['SubService'] = this.subService!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubService {
  dynamic id;
  dynamic serviceId;
  String? type;
  dynamic persontype;
  dynamic price;
  String? offer;
  List<dynamic>? image;
  String? details;
  dynamic timeTaken;
  dynamic userId;
  dynamic rating;
  String? termAndcondition;
  dynamic comment;
  dynamic status;

  SubService(
      {this.id,
        this.serviceId,
        this.type,
        this.persontype,
        this.price,
        this.offer,
        this.image,
        this.details,
        this.timeTaken,
        this.userId,
        this.rating,
        this.termAndcondition,
        this.comment,
        this.status});

  SubService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['serviceId'];
    type = json['type'];
    persontype = json['persontype'];
    price = json['price'];
    offer = json['offer'];
    image = json['image'];
    details = json['details'];
    timeTaken = json['timeTaken'];
    userId = json['userId'];
    rating = json['rating'];
    termAndcondition = json['termAndcondition'];
    comment = json['comment'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['serviceId'] = this.serviceId;
    data['type'] = this.type;
    data['persontype'] = this.persontype;
    data['price'] = this.price;
    data['offer'] = this.offer;
    data['image'] = this.image;
    data['details'] = this.details;
    data['timeTaken'] = this.timeTaken;
    data['userId'] = this.userId;
    data['rating'] = this.rating;
    data['termAndcondition'] = this.termAndcondition;
    data['comment'] = this.comment;
    data['status'] = this.status;
    return data;
  }
}
