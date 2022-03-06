class Shop {
  int? shopId;
  String? shopName;

  Shop({this.shopId, this.shopName});

  Shop.fromJson(Map<String, dynamic> json) {
    shopId = json['ShopId'];
    shopName = json['ShopName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ShopId'] = this.shopId;
    data['ShopName'] = this.shopName;
    return data;
  }
}
