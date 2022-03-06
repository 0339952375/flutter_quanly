class SellOutDetail {
  int? sellOutDetailId;
  int? sellOutId;
  int? productId;
  String? serinumer;
  int? quantity;
  int? amount;
  List<Prd>? prd;

  SellOutDetail({this.sellOutDetailId, this.sellOutId, this.productId, this.serinumer, this.quantity, this.amount, this.prd});

  SellOutDetail.fromJson(Map<String, dynamic> json) {
    sellOutDetailId = json['SellOutDetailId'];
    sellOutId = json['SellOutId'];
    productId = json['ProductId'];
    serinumer = json['Serinumer'];
    quantity = json['Quantity'];
    amount = json['Amount'];
    if (json['prd'] != null) {
      prd = <Prd>[];
      json['prd'].forEach((v) {
        prd!.add(new Prd.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SellOutDetailId'] = this.sellOutDetailId;
    data['SellOutId'] = this.sellOutId;
    data['ProductId'] = this.productId;
    data['Serinumer'] = this.serinumer;
    data['Quantity'] = this.quantity;
    data['Amount'] = this.amount;
    if (this.prd != null) {
      data['prd'] = this.prd!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Prd {
  int? productId;
  String? productName;
  int? price;
  int? categoryId;

  Prd({this.productId, this.productName, this.price, this.categoryId});

  Prd.fromJson(Map<String, dynamic> json) {
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
