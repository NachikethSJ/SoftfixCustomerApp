class BookingDetailListModel {
  String? bookingDate;
  String? bookingStatus;
  String? startTime;
  String? endTime;
  dynamic serviceId;
  String? service;
  dynamic shopId;
  String? shop;
  String? vendorId;
  String? employName;
  String? subServiceType;
  dynamic price;
  String? offer;

  BookingDetailListModel(
      {this.bookingDate,
        this.bookingStatus,
        this.startTime,
        this.endTime,
        this.serviceId,
        this.service,
        this.shopId,
        this.shop,
        this.vendorId,
        this.employName,
        this.subServiceType,
        this.price,
        this.offer});

  BookingDetailListModel.fromJson(Map<String, dynamic> json) {
    bookingDate = json['bookingDate'];
    bookingStatus = json['bookingStatus'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    serviceId = json['serviceId'];
    service = json['service'];
    shopId = json['shopId'];
    shop = json['shop'];
    vendorId = json['vendorId'];
    employName = json['employName'];
    subServiceType = json['sub_service_Type'];
    price = json['price'];
    offer = json['offer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingDate'] = this.bookingDate;
    data['bookingStatus'] = this.bookingStatus;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['serviceId'] = this.serviceId;
    data['service'] = this.service;
    data['shopId'] = this.shopId;
    data['shop'] = this.shop;
    data['vendorId'] = this.vendorId;
    data['employName'] = this.employName;
    data['sub_service_Type'] = this.subServiceType;
    data['price'] = this.price;
    data['offer'] = this.offer;
    return data;
  }
}
