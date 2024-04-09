class CartDetailsModel {
  dynamic cartId;
  dynamic productId;
  dynamic price;
  dynamic time;
  String? offer;
  String? type;
  String? name;
  List<dynamic>? image;

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
    image = json['image'];
  }

}
