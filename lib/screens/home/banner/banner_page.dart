import 'package:app_cooky/screens/home/banner/banner_load.dart';
import 'package:app_cooky/screens/home/banner/carouseindi.dart';
import 'package:app_cooky/screens/home/banner/route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: double.infinity,
      child: SafeArea(child: Obx(
        () {
          if (carouselController.isLoading.value) {
            return const Center(
              child: CarouselLoading(),
            );
          } else {
            if (carouselController.carouselItemList.isNotEmpty) {
              return CarouselWithIndicator(
                  data: carouselController.carouselItemList);
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.hourglass_empty),
                    Text("Data not found!")
                  ],
                ),
              );
            }
          }
        },
      )),
    );
  }
}
