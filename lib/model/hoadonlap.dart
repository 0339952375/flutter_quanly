class CreateSellOutDeltaill {
  int? sellOutId;
  String? customerName;
  String? customerMobile;
  int? shopId;
  int? billSeri;
  int? sellDate;
  int? amount;
  int? createDate;
  List<Lstdetail>? lstdetail;

  CreateSellOutDeltaill(
      {this.sellOutId,
      this.customerName,
      this.customerMobile,
      this.shopId,
      this.billSeri,
      this.sellDate,
      this.amount,
      this.createDate,
      this.lstdetail});

  CreateSellOutDeltaill.fromJson(Map<String, dynamic> json) {
    sellOutId = json['SellOutId'];
    customerName = json['CustomerName'];
    customerMobile = json['CustomerMobile'];
    shopId = json['ShopId'];
    billSeri = json['BillSeri'];
    sellDate = json['SellDate'];
    amount = json['Amount'];
    createDate = json['CreateDate'];
    if (json['lstdetail'] != null) {
      lstdetail = <Lstdetail>[];
      json['lstdetail'].forEach((v) {
        lstdetail!.add(new Lstdetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SellOutId'] = this.sellOutId;
    data['CustomerName'] = this.customerName;
    data['CustomerMobile'] = this.customerMobile;
    data['ShopId'] = this.shopId;
    data['BillSeri'] = this.billSeri;
    data['SellDate'] = this.sellDate;
    data['Amount'] = this.amount;
    data['CreateDate'] = this.createDate;
    if (this.lstdetail != null) {
      data['lstdetail'] = this.lstdetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lstdetail {
  int? sellOutDetailId;
  int? sellOutId;
  int? productId;
  String? serinumer;
  int? quantity;
  int? amount;
  Prd? prd;

  Lstdetail(
      {this.sellOutDetailId,
      this.sellOutId,
      this.productId,
      this.serinumer,
      this.quantity,
      this.amount,
      this.prd});

  Lstdetail.fromJson(Map<String, dynamic> json) {
    sellOutDetailId = json['SellOutDetailId'];
    sellOutId = json['SellOutId'];
    productId = json['ProductId'];
    serinumer = json['Serinumer'];
    quantity = json['Quantity'];
    amount = json['Amount'];
    prd = json['prd'] != null ? new Prd.fromJson(json['prd']) : null;
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
      data['prd'] = this.prd!.toJson();
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
