import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_tt/api.dart';
import 'package:test_tt/model/shop.dart';
import 'package:test_tt/page/search.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  List<Shop> shops = [];
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
    final shops = await SearchShop().getShop(query);
    setState(() => this.shops = shops);
  }

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
    return Scaffold(
        appBar: AppBar(
          title: Text('Quản lý shop'),
        ),
        body: ListView(
          children: [
            buildSearch(),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: shops.length,
                itemBuilder: (_, index) {
                  final shop = shops[index];
                  return Container(
                    margin: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Shop id:' + shop.shopId.toString(),
                          style: style,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Shop name:' + shop.shopName.toString(),
                              style: style,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                })
          ],
        ));
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Nhập id hoặc tên shop',
        onChanged: search,
      );
  Future search(String query) async => debounce(() async {
        final shops = await SearchShop().getShop(query);
        if (!mounted) return;
        setState(() {
          this.query = query;
          this.shops = shops;
        });
      });
}
