import 'package:app_cooky/screens/home/banner/banner_page.dart';
import 'package:app_cooky/screens/home/banner/bannerctr.dart';
import 'package:get/get.dart';

CarouselController carouselController = CarouselController.instance;

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CarouselController());
  }
}

class AppRoutes {
  static const String home = "/";
}

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.home,
      binding: HomeBinding(),
      page: () => const HomeScreen(),
    ),
  ];
}
