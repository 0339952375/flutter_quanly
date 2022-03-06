import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Quản lý bán hàng'),
          centerTitle: true,
        ),
        body: Wrap(
          alignment: WrapAlignment.center,
          spacing: 35,
          runSpacing: 35,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildButton(
                    context: context,
                    icon: Icon(
                      Icons.qr_code_sharp,
                      color: Colors.green[300],
                      size: 35,
                    ),
                    name: 'Sản phẩm',
                    link: '/sanpham'),
                buildButton(
                    context: context,
                    icon: Icon(
                      Icons.inventory_2,
                      color: Colors.green[300],
                      size: 35,
                    ),
                    name: 'Ngành hàng',
                    link: '/nganhHang'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildButton(
                    context: context,
                    icon: Icon(
                      Icons.local_convenience_store,
                      color: Colors.green[300],
                      size: 35,
                    ),
                    name: 'Shop',
                    link: '/shop'),
                buildButton(
                    context: context,
                    icon: Icon(
                      Icons.request_page_sharp,
                      color: Colors.green[300],
                      size: 35,
                    ),
                    name: 'Đơn hàng',
                    link: '/hoaDon'),
              ],
            ),
          ],
        ));
  }
}

Widget buildButton({required BuildContext context, required Icon icon, required String name, required String link}) => Container(
      margin: const EdgeInsets.only(top: 5.0),
      width: 100,
      height: 80,
      decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(5.0),
          gradient: const LinearGradient(colors: [Colors.grey, Colors.white]),
          boxShadow: const [BoxShadow(color: Colors.green, offset: Offset(1.5, 3.0))]),
      child: Column(
        children: [
          IconButton(onPressed: () => Navigator.pushNamed(context, link), icon: icon),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          )
        ],
      ),
    );
