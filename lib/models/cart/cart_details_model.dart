class CartDetailsModel {
  dynamic cartId;
  dynamic subServiceId;
  dynamic price;
  dynamic time;
  dynamic offer;
  dynamic type;
  dynamic name;
  List<dynamic>? image;

  CartDetailsModel(
      {this.cartId,
        this.subServiceId,
        this.price,
        this.time,
        this.offer,
        this.type,
        this.name,
        this.image});

  CartDetailsModel.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'];
    subServiceId = json['subServiceId'];
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
