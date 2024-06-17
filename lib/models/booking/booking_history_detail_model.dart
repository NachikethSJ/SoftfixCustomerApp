class BookingDetailListModel {
  dynamic orderId;
  String? bookingDate;
  String? bookingStatus;
  String? startTime;
  String? endTime;
  String? service;
  dynamic serviceId;
  dynamic shopId;
  String? shop;
  String? vendorId;
  String? employName;
  String? subServiceType;
  dynamic price;
  String? offer;
  dynamic subServiceId;
  bool? isReviewed;

  BookingDetailListModel(
      {this.orderId,
        this.bookingDate,
        this.bookingStatus,
        this.startTime,
        this.endTime,
        this.service,
        this.serviceId,
        this.shopId,
        this.shop,
        this.vendorId,
        this.employName,
        this.subServiceType,
        this.price,
        this.offer,
        this.subServiceId,
        this.isReviewed});

  BookingDetailListModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    bookingDate = json['bookingDate'];
    bookingStatus = json['bookingStatus'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    service = json['service'];
    serviceId = json['serviceId'];
    shopId = json['shopId'];
    shop = json['shop'];
    vendorId = json['vendorId'];
    employName = json['employName'];
    subServiceType = json['sub_service_Type'];
    price = json['price'];
    offer = json['offer'];
    subServiceId = json['subServiceId'];
    isReviewed = json['isReviewed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['bookingDate'] = this.bookingDate;
    data['bookingStatus'] = this.bookingStatus;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['service'] = this.service;
    data['serviceId'] = this.serviceId;
    data['shopId'] = this.shopId;
    data['shop'] = this.shop;
    data['vendorId'] = this.vendorId;
    data['employName'] = this.employName;
    data['sub_service_Type'] = this.subServiceType;
    data['price'] = this.price;
    data['offer'] = this.offer;
    data['subServiceId'] = this.subServiceId;
    data['isReviewed'] = this.isReviewed;
    return data;
  }
}
