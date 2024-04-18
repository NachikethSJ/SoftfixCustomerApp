class GetLatestUpdateModel {
  dynamic type;
  dynamic shopName;
  List<dynamic>? imageUrl;
  Details? details;
  List<ServiceIdData>? serviceIdData;
  dynamic membershipName;
  dynamic packageName;

  GetLatestUpdateModel(
      {this.type,
        this.shopName,
        this.imageUrl,
        this.details,
        this.serviceIdData,
        this.membershipName,
        this.packageName});

  GetLatestUpdateModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    shopName = json['shopName'];
    imageUrl = json['imageUrl'];
    details =
    json['Details'] != null ? Details.fromJson(json['Details']) : null;
    if (json['serviceIdData'] != null) {
      serviceIdData = <ServiceIdData>[];
      json['serviceIdData'].forEach((v) {
        serviceIdData!.add(ServiceIdData.fromJson(v));
      });
    }
    membershipName = json['membershipName'];
    packageName = json['packageName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = type;
    data['shopName'] = shopName;
    data['imageUrl'] = imageUrl;
    if (details != null) {
      data['Details'] = details!.toJson();
    }
    if (serviceIdData != null) {
      data['serviceIdData'] =
          serviceIdData!.map((v) => v.toJson()).toList();
    }
    data['membershipName'] = membershipName;
    data['packageName'] = packageName;
    return data;
  }
}

class Details {
  dynamic id;
  dynamic branchId;
  dynamic name;
  dynamic mobile;
  dynamic lat;
  dynamic lng;
  dynamic description;
  dynamic gstNo;
  dynamic tinNo;
  dynamic panNo;
  dynamic aadhaar;
  dynamic address;
  dynamic pin;
  dynamic file;
  dynamic country;
  dynamic state;
  dynamic city;
  dynamic status;
  dynamic token;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic isDelete;
  dynamic review;
  dynamic comment;
  dynamic percentage;
  dynamic otp;
  dynamic otpTime;
  dynamic vendorId;
  dynamic shopId;
  dynamic membershipName;
  dynamic serviceId;
  dynamic subServiceId;
  dynamic userId;
  dynamic startDate;
  dynamic endDate;
  dynamic price;
  dynamic serviceTypeId;
  dynamic offer;
  dynamic details;
  dynamic termAndcondition;
  dynamic mode;
  dynamic noOfTimes;
  dynamic packageName;
  dynamic discount;

  Details(
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
        this.mode,
        this.noOfTimes,
      
        this.packageName,
        this.discount});

  Details.fromJson(Map<String, dynamic> json) {
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
    mode = json['mode'];
    noOfTimes = json['noOfTimes'];
    isDelete = json['isDelete'];
    packageName = json['packageName'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['branchId'] = branchId;
    data['name'] = name;
    data['mobile'] = mobile;
    data['lat'] = lat;
    data['lng'] = lng;
    data['description'] = description;
    data['gstNo'] = gstNo;
    data['tinNo'] = tinNo;
    data['panNo'] = panNo;
    data['aadhaar'] = aadhaar;
    data['address'] = address;
    data['pin'] = pin;
    data['file'] = file;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['status'] = status;
    data['token'] = token;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['IsDelete'] = isDelete;
    data['review'] = review;
    data['comment'] = comment;
    data['percentage'] = percentage;
    data['otp'] = otp;
    data['otpTime'] = otpTime;
    data['vendorId'] = vendorId;
    data['shopId'] = shopId;
    data['membershipName'] = membershipName;
    data['serviceId'] = serviceId;
    data['subServiceId'] = subServiceId;
    data['userId'] = userId;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['price'] = price;
    data['serviceTypeId'] = serviceTypeId;
    data['offer'] = offer;
    data['details'] = details;
    data['termAndcondition'] = termAndcondition;
    data['mode'] = mode;
    data['noOfTimes'] = noOfTimes;
    data['isDelete'] = isDelete;
    data['packageName'] = packageName;
    data['discount'] = discount;
    return data;
  }
}

class ServiceIdData {
  dynamic serviceName;
  Details? details;
  dynamic subServiceName;

  ServiceIdData({this.serviceName, this.details, this.subServiceName});

  ServiceIdData.fromJson(Map<String, dynamic> json) {
    serviceName = json['serviceName'];
    details =
    json['Details'] != null ? Details.fromJson(json['Details']) : null;
    subServiceName = json['subServiceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['serviceName'] = serviceName;
    if (details != null) {
      data['Details'] = details!.toJson();
    }
    data['subServiceName'] = subServiceName;
    return data;
  }
}



