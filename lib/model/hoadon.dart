class SellOut {
  int? sellOutId;
  String? customerName;
  String? customerMobile;
  int? shopId;
  int? billSeri;
  int? sellDate;
  int? amount;
  int? createDate;

  SellOut(
      {this.sellOutId,
      this.customerName,
      this.customerMobile,
      this.shopId,
      this.billSeri,
      this.sellDate,
      this.amount,
      this.createDate});

  SellOut.fromJson(Map<String, dynamic> json) {
    sellOutId = json['SellOutId'];
    customerName = json['CustomerName'];
    customerMobile = json['CustomerMobile'];
    shopId = json['ShopId'];
    billSeri = json['BillSeri'];
    sellDate = json['SellDate'];
    amount = json['Amount'];
    createDate = json['CreateDate'];
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
    return data;
  }
}