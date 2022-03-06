import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_tt/api.dart';
import 'package:test_tt/model/product.dart';

class SanPham extends StatefulWidget {
  const SanPham({Key? key}) : super(key: key);

  @override
  State<SanPham> createState() => _SanPhamState();
}

String dropdownvalue = "All";
List<String> items = ["All", "Ti vi", "Tủ lạnh"];

class ChangeLayOut extends ChangeNotifier {
  changeLayOut() {
    if (dropdownvalue == "All") {
      return api_dsSanPham(0);
    }
    if (dropdownvalue == "Ti vi") {
      return api_dsSanPham(1);
    }
    if (dropdownvalue == "Tủ lạnh") {
      return api_dsSanPham(2);
    }
    notifyListeners();
  }
}

class _SanPhamState extends State<SanPham> {
  final txtTimKiem = TextEditingController();
  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);

    /* Lọc theo loai */
    Widget _buildPrdCategory() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
                value: dropdownvalue,
                icon: const Icon(
                  Icons.keyboard_arrow_down_sharp,
                  size: 30,
                ),
                items: items.map((String items) {
                  return DropdownMenuItem(value: items, child: Text(items));
                }).toList(),
                onChanged: (String? val) {
                  setState(() {
                    dropdownvalue = val!;
                  });
                })
          ],
        );
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quản lý sản phẩm'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 150,
                    child: Text('Loại sản phẩm'),
                  ),
                  _buildPrdCategory(),
                ],
              ),
              Consumer<ChangeLayOut>(
                builder: (context, clt, child) => Column(
                  children: [
                    FutureBuilder<List<Product>>(
                        future: clt.changeLayOut(),
                        builder: (_, snap) {
                          if (snap.hasError) {
                            print(snap.error);
                          }
                          return snap.hasData
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: snap.data!.length,
                                  itemBuilder: (_, index) {
                                    return Container(
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
                                                'Product id:' + snap.data![index].productId.toString(),
                                                style: style,
                                              ),
                                              Text(
                                                'Product name:' + snap.data![index].productName.toString(),
                                                style: style,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Category id:' + snap.data![index].categoryId.toString(),
                                                style: style,
                                              ),
                                              Text(
                                                'Price:' + snap.data![index].price.toString(),
                                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  })
                              : const Center(
                                  child: CupertinoActivityIndicator(),
                                );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
