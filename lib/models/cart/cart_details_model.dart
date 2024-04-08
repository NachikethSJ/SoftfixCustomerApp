class CartDetailsModel {
  int? cartId;
  int? productId;
  int? price;
  int? time;
  String? offer;
  String? type;
  String? name;
  List<String>? image;

  CartDetailsModel(
      {this.cartId,
        this.productId,
        this.price,
        this.time,
        this.offer,
        this.type,
        this.name,
        this.image});

  CartDetailsModel.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'];
    productId = json['productId'];
    price = json['price'];
    time = json['time'];
    offer = json['offer'];
    type = json['type'];
    name = json['name'];
    image = json['image'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cartId'] = this.cartId;
    data['productId'] = this.productId;
    data['price'] = this.price;
    data['time'] = this.time;
    data['offer'] = this.offer;
    data['type'] = this.type;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
