import 'package:app_cooky/myfolder/mydelivery_provider.dart';
import 'package:app_cooky/providers/user_provider.dart';

import 'package:app_cooky/screens/cart/review_cart.dart';
import 'package:app_cooky/screens/home/homepage.dart';
import 'package:app_cooky/screens/myprofile/profile.dart';

UserProvider userProvider = UserProvider();
HTProvider htProvider = HTProvider();
List pages = [
  Home_Screen(),
  ReviewCart(),
  MyProfile(),

  // ProfileScreen(),
  // CartScreen(),
];

//-------S
var namebar = "Trang chủ";
