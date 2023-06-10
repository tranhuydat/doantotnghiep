import 'package:app_cooky/screens/home/banner/banner_model.dart';
import 'package:app_cooky/screens/home/banner/banner_sv.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarouselController extends GetxController {
  static CarouselController instance = Get.find();
  RxList<CarouselModel> carouselItemList =
      List<CarouselModel>.empty(growable: true).obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void getData() async {
    try {
      isLoading(true);
      var result = await BannerService().getBanners();
      carouselItemList.assignAll(result);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
