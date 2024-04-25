class BookingDetailListModel {
  String? bookingDate;
  String? startTime;
  String? endTime;
  String? service;
  String? shop;
  String? employName;
  String? subServiceType;
  dynamic price;
  String? offer;

  BookingDetailListModel(
      {this.bookingDate,
        this.startTime,
        this.endTime,
        this.service,
        this.shop,
        this.employName,
        this.subServiceType,
        this.price,
        this.offer});

  BookingDetailListModel.fromJson(Map<String, dynamic> json) {
    bookingDate = json['bookingDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    service = json['service'];
    shop = json['shop'];
    employName = json['employName'];
    subServiceType = json['sub_service_Type'];
    price = json['price'];
    offer = json['offer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingDate'] = this.bookingDate;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['service'] = this.service;
    data['shop'] = this.shop;
    data['employName'] = this.employName;
    data['sub_service_Type'] = this.subServiceType;
    data['price'] = this.price;
    data['offer'] = this.offer;
    return data;
  }
}
