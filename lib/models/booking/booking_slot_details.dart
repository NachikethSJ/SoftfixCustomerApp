class BookSlotDetailsModel {
  String? bookingDate;
  String? startTime;
  String? endTime;
  String? employeeName;
  String? subServiceName;
  int? price;
  List<dynamic>? image;

  BookSlotDetailsModel(
      {this.bookingDate,
        this.startTime,
        this.endTime,
        this.employeeName,
        this.subServiceName,
        this.price,
        this.image});

  BookSlotDetailsModel.fromJson(Map<String, dynamic> json) {
    bookingDate = json['bookingDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    employeeName = json['employeeName'];
    subServiceName = json['subServiceName'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookingDate'] = this.bookingDate;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['employeeName'] = this.employeeName;
    data['subServiceName'] = this.subServiceName;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}
