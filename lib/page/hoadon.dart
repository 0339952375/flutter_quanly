import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_tt/api.dart';
import 'package:test_tt/controller/dssanphamhd.dart';
import 'package:test_tt/model/hoadon.dart';
import 'package:test_tt/model/product.dart';
import 'package:test_tt/model/selloutdetail.dart';
import 'package:test_tt/page/search.dart';

import 'chitietdonhang.dart';

class HoaDon extends StatefulWidget {
  const HoaDon({Key? key}) : super(key: key);

  @override
  State<HoaDon> createState() => _HoaDonState();
}

class _HoaDonState extends State<HoaDon> {
  List<SellOut> sellouts = [];
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
    final sellouts = await SearchSellOut().getSellOut(query);
    setState(() => this.sellouts = sellouts);
  }

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý đơn hàng'),
        actions: [
          OutlinedButton.icon(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Colors.red)))),
              onPressed: () => Navigator.pushNamed(context, '/laphoadon'),
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: const Text(
                'Thêm đơm hàng',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSearch(),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sellouts.length,
                itemBuilder: (_, index) {
                  final sellout = sellouts[index];
                  final createDate = sellout.createDate.toString();
                  final yyyy = createDate.substring(0, 4);
                  final mm = createDate.substring(4, 6);
                  final dd = createDate.substring(6, 8);
                  return Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.green[150],
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'BillSeri:' + sellout.billSeri.toString(),
                                  style: style,
                                ),
                                Text(
                                  'KH:' + sellout.customerName.toString(),
                                  style: style,
                                ),
                                Text(
                                  'SĐT:' + sellout.customerMobile.toString(),
                                  style: style,
                                )
                              ],
                            ),
                            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Text(
                                'Tổng tiền:' + sellout.amount.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                              ),
                              Text(
                                'Ngày lập:' + dd + '/' + mm + '/' + yyyy,
                                style: style,
                              ),
                            ]),
                            IconButton(
                                tooltip: "Xem chi tiết",
                                onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(builder: (BuildContext context) => PageSellOutDetail(sellout.sellOutId!)),
                                    ),
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ))
                          ],
                        ),
                      ),
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Nhập billseri hoặc tên khách hàng',
        onChanged: search,
      );
  Future search(String query) async => debounce(() async {
        final sellouts = await SearchSellOut().getSellOut(query);
        if (!mounted) return;
        setState(() {
          this.query = query;
          this.sellouts = sellouts;
        });
      });
}
