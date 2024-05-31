class CartDetailsModel {
  dynamic cartId;
  List<BookingDetailsSlotsCart>? bookingDetailsSlotsCart;
  dynamic subServiceId;
  dynamic price;
  dynamic time;
  dynamic offer;
  dynamic type;
  dynamic name;
  List<dynamic>? image;
  bool? isLoading;

  CartDetailsModel(
      {this.cartId,
        this.bookingDetailsSlotsCart,
        this.subServiceId,
        this.price,
        this.time,
        this.offer,
        this.type,
        this.name,
        this.image,this.isLoading});

  CartDetailsModel.fromJson(Map<String, dynamic> json) {
    isLoading=false;
    cartId = json['cartId'];
    if (json['bookingDetailsSlotsCart'] != null) {
      bookingDetailsSlotsCart = <BookingDetailsSlotsCart>[];
      json['bookingDetailsSlotsCart'].forEach((v) {
        bookingDetailsSlotsCart!.add(new BookingDetailsSlotsCart.fromJson(v));
      });
    }
    subServiceId = json['subServiceId'].toInt();
    price = json['price'];
    time = json['time'];
    offer = json['offer'];
    type = json['type'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cartId'] = this.cartId;
    if (this.bookingDetailsSlotsCart != null) {
      data['bookingDetailsSlotsCart'] =
          this.bookingDetailsSlotsCart!.map((v) => v.toJson()).toList();
    }
    data['subServiceId'] = this.subServiceId;
    data['price'] = this.price;
    data['time'] = this.time;
    data['offer'] = this.offer;
    data['type'] = this.type;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}

class BookingDetailsSlotsCart {
  dynamic startTime;
  dynamic endTime;
  dynamic employeeId;
  dynamic shopId;

  BookingDetailsSlotsCart(
      {this.startTime, this.endTime, this.employeeId, this.shopId});

  BookingDetailsSlotsCart.fromJson(Map<String, dynamic> json) {
    startTime = json['startTime'];
    endTime = json['endTime'];
    employeeId = json['employeeId'];
    shopId = json['shopId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['employeeId'] = this.employeeId;
    data['shopId'] = this.shopId;
    return data;
  }
}
