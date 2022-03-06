import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_tt/model/selloutdetail.dart';

import '../api.dart';

// ignore: must_be_immutable
class PageSellOutDetail extends StatelessWidget {
  PageSellOutDetail(this.id, {Key? key}) : super(key: key);
  int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết đơn hàng'),
      ),
      body: Column(
        children: [
          FutureBuilder<List<SellOutDetail>>(
              future: api_sellOutDetail(id),
              builder: (_, snap) {
                if (snap.hasError) {
                  //ignore: avoid_print
                  print(snap.error);
                }
                return snap.hasData
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snap.data!.length,
                        itemBuilder: (_, index) {
                          return Container(
                            margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
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
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Serinumer:' + snap.data![index].serinumer.toString(),
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Product Name:' + snap.data![index].prd![0].productName.toString(),
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text('Quantity:' + snap.data![index].quantity.toString(),
                                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                                    Text(
                                      'Amount:' + snap.data![index].amount.toString(),
                                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
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
              })
        ],
      ),
    );
  }
}
