class CartProduct {
  String name;
  int qty;
  String? picturePath;
  double price;
  bool isHalf;

  CartProduct({
    required this.name,
    required this.qty,
    required this.picturePath,
    required this.price,
    required this.isHalf,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'qty': qty,
      'picturePath': picturePath,
      'price': price,
      'isHalf': isHalf,
    };
  }

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      name: json['name'],
      qty: json['qty'],
      picturePath: json['picturePath'],
      price: json['price'],
      isHalf: json['isHalf'],
    );
  }
}
