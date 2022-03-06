import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_tt/Home.dart';
import 'package:test_tt/page/addprdhoadon.dart';
import 'package:test_tt/page/hoadon.dart';
import 'package:test_tt/page/khachhang.dart';
import 'package:test_tt/page/laphoadon.dart';
import 'package:test_tt/page/nganhhang.dart';
import 'package:test_tt/page/sanpham.dart';

import 'package:test_tt/page/shop.dart';
import 'package:test_tt/page/successsell.dart';

import 'controller/dssanphamhd.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChangeLayOut()),
        ChangeNotifierProvider(create: (_) => DsSanPhamProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PV_Test',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const HomeScreen(),
        routes: {
          '/home':(context)=>const HomeScreen(),
          '/khachHang': (context) => const KhachHang(),
          '/hoaDon': (context) => const HoaDon(),
          '/nganhHang': (context) => const NganhHang(),
          '/shop': (context) => const ShopPage(),
          '/sanpham': (context) => const SanPham(),
          "/addprdhoadon": (context) => const AddHoaDon(),
          "/laphoadon":(context)=>  const LapHoaDon(),
          "/successsell":(context)=>const SuccessfullyPage(),
        },
      ),
    );
  }
}
