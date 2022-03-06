import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:test_tt/api.dart';
import 'package:test_tt/controller/dssanphamhd.dart';
import 'package:test_tt/model/product.dart';

class LapHoaDon extends StatefulWidget {
  const LapHoaDon({Key? key}) : super(key: key);
  @override
  State<LapHoaDon> createState() => _LapHoaDonState();
}

class _LapHoaDonState extends State<LapHoaDon> {
  final txtTenKh = TextEditingController();
  final txtSdt = TextEditingController();
  final txtSeri = TextEditingController();
  bool _validateTenKh = false;
  bool _validateSdt = false;
  bool _validateSeri = false;
  @override
  void dispose() {
    txtTenKh.dispose();
    txtSdt.dispose();
    txtSeri.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Thêm hoá đơn",
          ),
        ),
        body: SingleChildScrollView(
          child: Consumer<DsSanPhamProvider>(
              builder: (_, prdprovider, child) => prdprovider.getProduct.isEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Chưa có sản phẩm",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(context, "/addprdhoadon"),
                              child: Container(
                                  alignment: Alignment.center,
                                  width: 200,
                                  height: 50.0,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      gradient: LinearGradient(colors: [
                                        Colors.red,
                                        Colors.orange,
                                      ]),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 0),
                                          color: Colors.pink,
                                          blurRadius: 16.0,
                                        ),
                                      ]),
                                  child:
                                      const Text("Chọn sản phẩm", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15))),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: prdprovider.getProduct.length,
                            itemBuilder: (_, index) {
                              return Container(
                                margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                                width: 3,
                                height: 50,
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                decoration: BoxDecoration(
                                    color: Colors.green[150],
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Tên:' + prdprovider.getProduct[index].productName!,
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                    Text(
                                      'Giá:' + prdprovider.getProduct[index].price.toString(),
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                    IconButton(
                                        onPressed: () => prdprovider.removeAt(index, prdprovider.getProduct[index].price!),
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.deepOrange,
                                        ))
                                  ],
                                ),
                              );
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10, right: 10),
                              child: Text(
                                'Tổng tiên:' + prdprovider.getTongTien.toString(),
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.amber),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pushNamed(context, '/addprdhoadon'),
                              child: const Text('Thêm sản phẩm', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.blue)),
                            ),
                            TextButton.icon(
                                onPressed: () => prdprovider.removeAll(prdprovider.getProduct),
                                icon: const Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                ),
                                label: const Text('Clear'))
                          ],
                        )
                      ],
                    )),
        ),
        bottomNavigationBar: Material(
          color: Colors.amber[300],
          child: InkWell(
            onTap: () {
              laphoadon(context);
            },
            child: const SizedBox(
              height: kToolbarHeight,
              width: double.infinity,
              child: Center(
                child: Text(
                  'Lập hoá đơn',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showMyDialog() => showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Nhập seri sản phẩm'),
            content: TextFormField(
              autofocus: true,
              controller: txtSeri,
              decoration: InputDecoration(
                  hintText: "Seri ",
                  errorText: _validateTenKh ? 'Seri không được trống' : null,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.blueGrey))),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                onPressed: () async {
                  final prdProvider = Provider.of<DsSanPhamProvider>(context, listen: false);
                  bool check = await checkserinumber(txtSeri.text);
                  if (check) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Seri đã tồn tại"),
                    ));
                  } else {
                    prdProvider.addSeri(txtSeri.text);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Thêm seri'),
              ),
            ],
          );
        },
      );
  void laphoadon(context) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Thêm khách hàng'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Consumer<DsSanPhamProvider>(
                    builder: (_, prdprovider, child) => Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.label),
                          title: const Text('Tên KH'),
                          subtitle: SizedBox(
                            width: 200,
                            child: TextFormField(
                              autofocus: true,
                              controller: txtTenKh,
                              decoration: InputDecoration(
                                  hintText: "Tên khách hàng",
                                  errorText: _validateTenKh ? 'Tên khách hàng không được trống!' : null,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.blueGrey))),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.phone),
                          title: const Text('Số điện thoại'),
                          subtitle: SizedBox(
                            width: 200,
                            child: TextFormField(
                              autofocus: true,
                              controller: txtSdt, //gan gia tri cua text vao bien'
                              decoration: InputDecoration(
                                border:
                                    OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.blueGrey)),
                                errorText: _validateSdt ? 'Số đt không được trống!' : null,
                              ),
                              inputFormatters: <TextInputFormatter>[
                                //only number
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ),
                        Container(
                            height: 300.0, // Change as per your requirement
                            width: 300.0, // Change as per your requirement
                            child: ListView.builder(
                              // physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: prdprovider.getProduct.length,
                              itemBuilder: (_, index) => prdprovider.getProduct.isNotEmpty
                                  ? Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(prdprovider.getProduct[index].productName!),
                                        ),
                                        Container(
                                          width: 150,
                                          padding: const EdgeInsets.only(bottom: 20),
                                          child: OutlinedButton.icon(
                                              style: ButtonStyle(
                                                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Colors.red)))),
                                              onPressed: () => _showMyDialog(),
                                              icon: const Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                              label: const Text(
                                                'Thêm Seri',
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                                              )),
                                        )
                                      ],
                                    )
                                  : const SizedBox(),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Bỏ qua',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            TextButton(
                onPressed: () async {
                  final lstprd = Provider.of<DsSanPhamProvider>(context, listen: false);
                  final tongtien = lstprd.getTongTien;
                  txtTenKh.text.isEmpty ? _validateTenKh = true : _validateTenKh = false;
                  txtSdt.text.isEmpty ? _validateSdt = true : _validateSdt = false;
                  txtSeri.text.isEmpty ? _validateSeri = true : _validateSeri = false;
                  final crehoadon = await createSellOut(lstprd.getProduct, lstprd.getLstSeri, txtTenKh.text, txtSdt.text, tongtien);
                  if (crehoadon == true) {
                    print("tao tc");
                    txtTenKh.clear();
                    txtSdt.clear();
                    txtSeri.clear();
                    lstprd.removeAll(lstprd.getProduct);
                    lstprd.removeAllSeri(lstprd.getLstSeri);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Lập hoá đơn thành công"),
                    ));
                    Navigator.pushNamed(context, '/successsell');
                  } else {
                    print('tao that bai');
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Lập hoá đơn thất bại"),
                    ));
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Thêm',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ))
          ],
        );
      });
}
