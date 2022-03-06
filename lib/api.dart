// ignore: non_constant_identifier_names
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:test_tt/controller/dssanphamhd.dart';
import 'package:test_tt/model/category.dart';
import 'package:test_tt/model/hoadonlap.dart';
import 'package:test_tt/model/product.dart';
import 'package:test_tt/model/selloutdetail.dart';

import 'model/hoadon.dart';
import 'model/shop.dart';

/* SELLOUT */
const jsonSellOut = '''
  {
    "status":200,
    "data":[
      {
      "SellOutId":1,
      "CustomerName":"Thắng",
      "CustomerMobile":"0908185626",
      "ShopId":1,
      "BillSeri":3232,
      "SellDate":20210506,
      "Amount":10000000,
      "CreateDate":20210506123012
    },
    {
      "SellOutId":2,
      "CustomerName":"Quốc",
      "CustomerMobile":"0905591500",
      "ShopId":2,
      "BillSeri":4343,
      "SellDate":20210506,
      "Amount":7000000,
      "CreateDate":20210506123012
    }
    ]
  }
''';
Future<List<SellOut>> api_dsHoaDon() async {
  List<SellOut> lstSellOut = [];
  try {
    final response = await Future.delayed(const Duration(seconds: 2), () => jsonSellOut);
    Map<String, dynamic> jsonRaw = json.decode(response);
    final List data = jsonRaw['data'];
    lstSellOut = data.map((e) => SellOut.fromJson(e)).toList();
  } catch (_) {}
  return lstSellOut;
}

/* SELLOUTDETAIL to id */
const jsonSellOutDetailId0 = '''
  {
    "status":200,
    "data":[
      {
      "SellOutDetailId":1,
      "SellOutId":1,
      "ProductId":1,
      "Serinumer":"4343434",
      "Quantity":1,
      "Amount":10000000,
      "prd":[
        {
           "ProductId":1,
           "ProductName":"TV 32in GHKFKFFF",
           "Price":10000000,
           "CategoryId":1
        }
      ]
    },
     {
      "SellOutDetailId":2,
      "SellOutId":2,
      "ProductId":3,
      "Serinumer":"4343y4nj",
      "Quantity":1,
      "Amount":3000000,
      "prd":[
        {
           "ProductId":2,
           "ProductName":"Tủ lạnh Samsung 250 lít",
           "Price":3000000,
           "CategoryId":2
        }
      ]
    },
    {
      "SellOutDetailId":3,
      "SellOutId":2,
      "ProductId":4,
      "Serinumer":"544uyh5j454",
      "Quantity":1,
      "Amount":4000000,
      "prd":[
        {
           "ProductId":4,
           "ProductName":"Tủ lạnh Samsung 350 lít",
           "Price":4000000,
           "CategoryId":2
        }
      ]
    }
    ]
  }
''';
const jsonSellOutDetailId1 = '''
  {
    "status":200,
    "data":[
      {
      "SellOutDetailId":1,
      "SellOutId":1,
      "ProductId":1,
      "Serinumer":"4343434",
      "Quantity":1,
      "Amount":10000000,
      "prd":[
        {
           "ProductId":1,
           "ProductName":"TV 32in GHKFKFFF",
           "Price":10000000,
           "CategoryId":1
        }
      ]
    }
    ]
  }
''';
const jsonSellOutDetailId2 = '''
  {
    "status":200,
    "data":[
      {
      "SellOutDetailId":2,
      "SellOutId":2,
      "ProductId":3,
      "Serinumer":"4343y4nj",
      "Quantity":1,
      "Amount":3000000,
      "prd":[
        {
           "ProductId":2,
           "ProductName":"Tủ lạnh Samsung 250 lít",
           "Price":3000000,
           "CategoryId":2
        }
      ]
    },
    {
      "SellOutDetailId":3,
      "SellOutId":2,
      "ProductId":4,
      "Serinumer":"544uyh5j454",
      "Quantity":1,
      "Amount":4000000,
      "prd":[
        {
           "ProductId":4,
           "ProductName":"Tủ lạnh Samsung 350 lít",
           "Price":4000000,
           "CategoryId":2
        }
      ]
    }
    ]
  }
''';
Future<List<SellOutDetail>> api_sellOutDetail(int id) async {
  List<SellOutDetail> lstSellOutDetail = [];
  try {
    String jsonString = "";
    if (id == 0) {
      jsonString = jsonSellOutDetailId0;
    }
    if (id == 1) {
      jsonString = jsonSellOutDetailId1;
    }
    if (id == 2) {
      jsonString = jsonSellOutDetailId2;
    }
    final response = await Future.delayed(const Duration(seconds: 2), () => jsonString);
    Map<String, dynamic> jsonRaw = json.decode(response);
    final List data = jsonRaw['data'];
    lstSellOutDetail = data.map((e) => SellOutDetail.fromJson(e)).toList();
  } catch (_) {}
  return lstSellOutDetail;
}

/* CATEGORY */
const jsonCategory = '''
{
  "status":200,
  "data":[
    {
      "CategoryId":1,
      "CategoryName":"Ti vi"
    },
    {
      "CategoryId":2,
      "CategoryName":"Tủ lạnh"
    }
  ]
}
''';
Future<List<Category>> api_dsNganhHang() async {
  List<Category> lstCateGory = [];
  try {
    final response = await Future.delayed(const Duration(seconds: 2), () => jsonCategory);
    Map<String, dynamic> jsonRaw = json.decode(response);
    final List data = jsonRaw['data'];
    lstCateGory = data.map((e) => Category.fromJson(e)).toList();
  } catch (_) {}
  return lstCateGory;
}

/* PRODUCT */
const jsonProduct = '''
{
  "status":200,
  "data":[
    {
      "ProductId":1,
      "ProductName":"TV 32in GHKFKFFF",
      "Price":10000000,
      "CategoryId":1
    },
    {
      "ProductId":2,
      "ProductName":"TV 42in GHKFKFFF",
      "Price":3000000,
      "CategoryId":1
    },
    {
      "ProductId":3,
      "ProductName":"Tủ lạnh Samsung 250 lít",
      "Price":2000000,
      "CategoryId":2
    },
    {
      "ProductId":4,
      "ProductName":"Tủ lạnh Samsung 350 lít",
      "Price":2000000,
      "CategoryId":2
    }
  ]
}
''';
/* product category id=1  */
const jsonPrdCategory1 = '''
{
  "status":200,
  "data":[
    {
      "ProductId":1,
      "ProductName":"TV 32in GHKFKFFF",
      "Price":10000000,
      "CategoryId":1
    },
    {
      "ProductId":2,
      "ProductName":"TV 42in GHKFKFFF",
      "Price":3000000,
      "CategoryId":1
    }
  ]
}
''';
/* product category id=2  */
const jsonPrdCategory2 = '''
  {
    "status":200,
    "data":[
    {
      "ProductId":3,
      "ProductName":"Tủ lạnh Samsung 250 lít",
      "Price":2000000,
      "CategoryId":2
    },
    {
      "ProductId":4,
      "ProductName":"Tủ lạnh Samsung 350 lít",
      "Price":2000000,
      "CategoryId":2
    }
  ]
  }
''';
/* Product category id  */
Future<List<Product>> api_dsSanPham(int id) async {
  List<Product> lstProduct = [];
  try {
    String jsonString = "";
    if (id == 0) {
      jsonString = jsonProduct;
    }
    if (id == 1) {
      jsonString = jsonPrdCategory1;
    }
    if (id == 2) {
      jsonString = jsonPrdCategory2;
    }
    final response = await Future.delayed(const Duration(seconds: 0), () => jsonString);
    Map<String, dynamic> jsonRaw = json.decode(response);
    final List data = jsonRaw['data'];
    lstProduct = data.map((e) => Product.fromJson(e)).toList();
  } catch (_) {}
  return lstProduct;
}
/* SHOP */

const jsonShop = '''{
  "status":200,
  "data":[
    {
      "ShopId":1,
      "ShopName":"Nguyễn Kim Quận 1"
    },
    {
      "ShopId":2,
      "ShopName":"Nguyễn Kim Trần Hưng đạo"
    }
  ]
}
''';
// ignore: non_constant_identifier_names
Future<List<Shop>> api_dsShop() async {
  List<Shop> lstShop = [];
  try {
    final response = await Future.delayed(const Duration(seconds: 2), () => jsonShop);
    Map<String, dynamic> jsonRaw = json.decode(response);
    final List data = jsonRaw['data'];
    lstShop = data.map((e) => Shop.fromJson(e)).toList();
  } catch (_) {}
  return lstShop;
}
/* SEARCH PRODUCT */

class SearchPrd {
  Future<List<Product>> getProduct(String query) async {
    final response = await Future.delayed(const Duration(seconds: 2), () => jsonProduct);
    Map<String, dynamic> jsonRaw = json.decode(response);
    final List data = jsonRaw['data'];
    return data.map((e) => Product.fromJson(e)).where((prd) {
      final prdName = prd.productName!.toLowerCase();
      final searchQuery = query.toLowerCase();
      return prdName.contains(searchQuery);
    }).toList();
  }
}

/* SEARCH CATEGORY */
class SearchCategory {
  Future<List<Category>> getCategory(String query) async {
    final response = await Future.delayed(const Duration(seconds: 0), () => jsonCategory);
    Map<String, dynamic> jsonRaw = json.decode(response);
    final List data = jsonRaw['data'];
    return data.map((e) => Category.fromJson(e)).where((ctr) {
      final ctrName = ctr.categoryName!.toLowerCase();
      final ctrid = ctr.categoryId!.toString().toLowerCase();
      final searchQuery = query.toLowerCase();
      return ctrName.contains(searchQuery) || ctrid.contains(searchQuery);
    }).toList();
  }
}

/* SEARCH SHOP */
class SearchShop {
  Future<List<Shop>> getShop(String query) async {
    final response = await Future.delayed(const Duration(seconds: 0), () => jsonShop);
    Map<String, dynamic> jsonRaw = json.decode(response);
    final List data = jsonRaw['data'];
    return data.map((e) => Shop.fromJson(e)).where((shp) {
      final shpName = shp.shopName!.toLowerCase();
      final shpid = shp.shopId!.toString().toLowerCase();
      final searchQuery = query.toLowerCase();
      return shpName.contains(searchQuery) || shpid.contains(searchQuery);
    }).toList();
  }
}

/* SEARCH SELLOUT */
class SearchSellOut {
  Future<List<SellOut>> getSellOut(String query) async {
    final response = await Future.delayed(const Duration(seconds: 0), () => jsonSellOut);
    Map<String, dynamic> jsonRaw = json.decode(response);
    final List data = jsonRaw['data'];
    return data.map((e) => SellOut.fromJson(e)).where((slot) {
      final slotSeri = slot.billSeri!.toString().toLowerCase();
      final slotKH = slot.customerName!.toString().toLowerCase();
      final searchQuery = query.toLowerCase();
      return slotSeri.contains(searchQuery) || slotKH.contains(searchQuery);
    }).toList();
  }
}

/* SEARCH SELLOUT */
class SearchProduct {
  Future<List<Product>> getProduct(String query) async {
    final response = await Future.delayed(const Duration(seconds: 0), () => jsonProduct);
    Map<String, dynamic> jsonRaw = json.decode(response);
    final List data = jsonRaw['data'];
    return data.map((e) => Product.fromJson(e)).where((prd) {
      final prdName = prd.productName!.toLowerCase();
      final prdId = prd.productId!.toString().toLowerCase();
      final searchQuery = query.toLowerCase();
      return prdName.contains(searchQuery) || prdId.contains(searchQuery);
    }).toList();
  }
}
/* CREATE SELLOUT */

/* api create sellout detail */
const jsonCreateSellOut = '''
  {
    "status":200,
    "data":[
      {
        "SellOutId":1,
        "CustomerName":"Thắng",
        "CustomerMobile":"0908185626",
        "ShopId":1,
        "BillSeri":3232,
        "SellDate":20210506,
        "Amount":10000000,
        "CreateDate":20210506123012,
        "lstdetail":[
            {
              "SellOutDetailId":3,
              "SellOutId":2,
              "ProductId":4,
              "Serinumer":"544uyh5j454",
              "Quantity":1,
              "Amount":4000000,
              "prd":
                {
                   "ProductId":4,
                   "ProductName":"Tủ lạnh Samsung 350 lít",
                   "Price":4000000,
                   "CategoryId":2
                }
            }
         ]
      }
    ]
  }
''';
Future<bool> checkserinumber(String seri) async {
  final lstSelloutdetail = await api_sellOutDetail(0);
  final ss = lstSelloutdetail.where((element) => element.serinumer == seri).toList();
  return ss.isNotEmpty ? true : false;
}
Future<bool> createSellOut(List<Product> lstprd,List<String> lstSeri, String tenKh, String sdt, int tongtien) async {
    List<Lstdetail> lstSelloutDetail = [];
    if (lstprd.isEmpty || tenKh == "" || sdt == "" ) {
      return false;
    }
    // lstprd.forEach((element) { })
    for (var i = 0; i < lstprd.length; i++) {
      for (var j = 0; j <lstSeri.length ; j++) {
        if(i==j){
          final selloutdetail =
            Lstdetail(sellOutDetailId: 4, sellOutId: 12, productId: lstprd[i].productId, serinumer: lstSeri[j], quantity: 1, amount: lstprd[i].price);
        lstSelloutDetail.add(selloutdetail);
        }
        
      }
      
    }

    final creaSellOutDeltail = CreateSellOutDeltaill(
        sellOutId: 12,
        customerName: tenKh,
        customerMobile: sdt,
        shopId: 1,
        billSeri: 565656,
        sellDate: 20220306,
        amount: tongtien,
        createDate: 202203061411,
        lstdetail: lstSelloutDetail);
    Map<String, dynamic> jsonRaw = creaSellOutDeltail.toJson();
    // ignore: unrelated_type_equality_checks
    return (jsonRaw=="") ? false : true;
 
}
