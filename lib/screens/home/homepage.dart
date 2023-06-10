import 'package:app_cooky/screens/home/banner/banner_page.dart';
import 'package:app_cooky/screens/home/banner/bannerctr.dart';
import 'package:app_cooky/screens/home/category/category_p.dart';
import 'package:app_cooky/screens/home/productfolder.dart/productscreen.dart';
import 'package:app_cooky/utils/mystring.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  void initState() {
    Get.put(CarouselController());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
              maxHeight: double.infinity, maxWidth: double.infinity),
          child: SingleChildScrollView(
            child: Column(children: [
              HomeScreen(),
              Category_Page(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sản phẩm',
                      style: TextStyle(color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => Search(
                        //       search: productProvider.getHerbsProductDataList,
                        //     ),
                        //   ),
                        // );
                      },
                      child: Text(
                        'Xem thêm >>',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              Product_page(),
            ]),
          ),
        ),
      ),
    );
  }
}
