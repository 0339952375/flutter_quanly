import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_tt/api.dart';
import 'package:test_tt/model/category.dart';
import 'package:test_tt/page/search.dart';

class NganhHang extends StatefulWidget {
  const NganhHang({Key? key}) : super(key: key);

  @override
  State<NganhHang> createState() => _NganhHangState();
}

class _NganhHangState extends State<NganhHang> {
  // final txtTimKiem = TextEditingController();
  List<Category> categorys = [];
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
    final categorys = await SearchCategory().getCategory(query);
    setState(() => this.categorys = categorys);
  }

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quản lý ngành hàng'),
        ),
        body: Column(
          children: [
            buildSearch(),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categorys.length,
                itemBuilder: (_, index) {
                  final category = categorys[index];
                  return Container(
                    margin: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
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
                          'Category Id:' + category.categoryId.toString(),
                          style: style,
                        ),
                        Text(
                          'Category Name:' + category.categoryName.toString(),
                          style: style,
                        ),
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Nhập id hoặc tên loại sản phẩm',
        onChanged: search,
      );
  Future search(String query) async => debounce(() async {
        final categorys = await SearchCategory().getCategory(query);
        if (!mounted) return;
        setState(() {
          this.query = query;
          this.categorys = categorys;
        });
      });
}
