class Product {
  int? productId;
  String? productName;
  int? price;
  int? categoryId;

  Product({this.productId, this.productName, this.price, this.categoryId});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['ProductId'];
    productName = json['ProductName'];
    price = json['Price'];
    categoryId = json['CategoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProductId'] = this.productId;
    data['ProductName'] = this.productName;
    data['Price'] = this.price;
    data['CategoryId'] = this.categoryId;
    return data;
  }
}
