class NearByShopModel {
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
  double? rating;
  String? countryName;
  String? stateName;
  String? cityName;
  String? branchName;
  List<dynamic>? imageUrl;

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
        this.rating,
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
    rating = json['rating'];
    countryName = json['countryName'];
    stateName = json['stateName'];
    cityName = json['cityName'];
    branchName = json['branchName'];
    imageUrl = json['imageUrl'];
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
    data['rating'] = this.rating;
    data['countryName'] = this.countryName;
    data['stateName'] = this.stateName;
    data['cityName'] = this.cityName;
    data['branchName'] = this.branchName;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
