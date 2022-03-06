import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_tt/api.dart';
import 'package:test_tt/controller/dssanphamhd.dart';
import 'package:test_tt/model/product.dart';
import 'package:test_tt/page/search.dart';

class AddHoaDon extends StatefulWidget {
  const AddHoaDon({Key? key}) : super(key: key);

  @override
  State<AddHoaDon> createState() => _AddHoaDonState();
}

class _AddHoaDonState extends State<AddHoaDon> {
  List<Product> products = [];
  String query = "";
  Timer? debouncer;
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final products = await SearchProduct().getProduct(query);
    setState(() => this.products = products);
  }

  @override
  Widget build(BuildContext context) {
    final prdProvider=Provider.of<DsSanPhamProvider>(context,listen: false);
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chọn sản phẩm'),
        ),
        body: ListView(
          children: [
            buildSearch(),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (_, index) {
                  final prd = products[index];
                  return Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
                        padding: const EdgeInsets.all(8.0),
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.green[150],
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Product id:' + prd.productId.toString(),
                                  style: style,
                                ),
                                Text(
                                  'Product name:' + prd.productName.toString(),
                                  style: style,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Category id:' + prd.categoryId.toString(),
                                  style: style,
                                ),
                                Text(
                                  'Price:' + prd.price.toString(),
                                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          right: 3.0,
                          top: 5.0,
                          child: TextButton(
                            
                              onPressed: () => prdProvider.addPrsHD(prd),
                              child: const Text(
                                "Thêm",
                                style: TextStyle(color: Colors.blue),
                              )))
                    ],
                  );
                })
          ],
        ));
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Nhập id hoặc tên sản phẩm',
        onChanged: searchBook,
      );
  Future searchBook(String query) async => debounce(() async {
        final products = await SearchProduct().getProduct(query);
        if (!mounted) return;
        setState(() {
          this.query = query;
          this.products = products;
        });
      });
}
