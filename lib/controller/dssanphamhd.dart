import 'package:flutter/cupertino.dart';
import 'package:test_tt/model/product.dart';

class DsSanPhamProvider extends ChangeNotifier {
  List<Product> lstprd = [];
  int tongTien = 0;

  void addPrsHD(Product prd) async {
    lstprd.add(prd);
    tongTien = tongTien + prd.price!;
    print('add prd succes');
    print(tongTien);
    notifyListeners();
  }

  List<Product> get getProduct => lstprd;
  int get getTongTien => tongTien;

  void removeAt(int index,int prdprice){
    lstprd.removeAt(index);
    tongTien=tongTien-prdprice;
    notifyListeners();
  }
  void removeAll(List<Product> lstprd) {
    // print(lstprd);
    lstprd.clear();
    tongTien = 0;
    print(lstprd);
    notifyListeners();
  }

  List<String> lstseri = [];
  void addSeri(String seri){
    print(seri);
    lstseri.add(seri);
    notifyListeners();
  }
  void removeAllSeri(List<String> lstSeri) {
    // print(lstprd);
    lstSeri.clear();
    notifyListeners();
  }
  List<String> get getLstSeri=>lstseri;
}
