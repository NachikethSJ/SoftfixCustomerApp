class GetBookingDetailsModel {
  int? employeeId;
  int? serviceTypeId;
  String? bookingDate;
  String? bookingStartTime;
  String? bookingEndTime;
  String? promocode;
  int? tax;
  double? latitude;
  double? longitude;
  int? bookingStatus;
  int? paymentStatus;
  int? bookingId;
  int? userId;

  GetBookingDetailsModel(
      {this.employeeId,
        this.serviceTypeId,
        this.bookingDate,
        this.bookingStartTime,
        this.bookingEndTime,
        this.promocode,
        this.tax,
        this.latitude,
        this.longitude,
        this.bookingStatus,
        this.paymentStatus,
        this.bookingId,
        this.userId});

  GetBookingDetailsModel.fromJson(Map<String, dynamic> json) {
    employeeId = json['employeeId'];
    serviceTypeId = json['serviceTypeId'];
    bookingDate = json['bookingDate'];
    bookingStartTime = json['bookingStartTime'];
    bookingEndTime = json['bookingEndTime'];
    promocode = json['promocode'];
    tax = json['tax'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    bookingStatus = json['bookingStatus'];
    paymentStatus = json['paymentStatus'];
    bookingId = json['bookingId'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeId'] = this.employeeId;
    data['serviceTypeId'] = this.serviceTypeId;
    data['bookingDate'] = this.bookingDate;
    data['bookingStartTime'] = this.bookingStartTime;
    data['bookingEndTime'] = this.bookingEndTime;
    data['promocode'] = this.promocode;
    data['tax'] = this.tax;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['bookingStatus'] = this.bookingStatus;
    data['paymentStatus'] = this.paymentStatus;
    data['bookingId'] = this.bookingId;
    data['userId'] = this.userId;
    return data;
  }
}
