
import 'package:app_cooky/providers/product_provider.dart';
import 'package:app_cooky/screens/cart/review_cart.dart';
import 'package:app_cooky/screens/home/seacrch/search.dart';
import 'package:app_cooky/screens/myprofile/drawside.dart';
import 'package:app_cooky/utils/mycolors.dart';
import 'package:app_cooky/utils/mystring.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadScreen extends StatefulWidget {
  const LoadScreen({super.key});

  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  late ProductProvider productProvider;
 
  int curent_index = 0;
  void onTap(int index) {
    setState(() {
      curent_index = index;
    });
  }

  @override
  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.gerAllProductSearch;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
   
    setState(() {
      if (curent_index == 0) {
        namebar = "Trang chủ";
      } else if (curent_index == 1) {
        namebar = "Giỏ Hàng";
      } else {
        namebar = "Cá nhân";
      }
    });
    return Scaffold(
      //--------
      drawer: DrawerSide(userProvider: userProvider),
      appBar: AppBar(
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          namebar,
          style: TextStyle(color: textColor, fontSize: 17),
        ),
        actions: [
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        Search(search: productProvider.herbsProductList),
                  ),
                );
              },
              icon: Icon(
                Icons.search,
                size: 17,
                color: textColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ReviewCart(),
                  ),
                );
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 15,
                child: Icon(
                  Icons.shop,
                  size: 17,
                  color: textColor,
                ),
              ),
            ),
          ),
        ],
      ),

      //----------------
      body: pages[curent_index],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: onTap,
          currentIndex: curent_index,
          selectedItemColor: Colors.black54,
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          showUnselectedLabels: false,
          showSelectedLabels: false,
          elevation: 0,
          backgroundColor: Colors.white60,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Cart',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.verified_user),
                label: 'User',
                backgroundColor: Colors.white),
          ]),
    );
  }
}
