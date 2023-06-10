import 'dart:ui';

import 'package:app_cooky/screens/cart/count.dart';
import 'package:app_cooky/screens/cart/review_cart.dart';
import 'package:app_cooky/screens/cart/singe_items.dart';
import 'package:app_cooky/utils/mycolors.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:intl/intl.dart';

enum SinginCharacter { fill, outline }

class ProductOverview extends StatefulWidget {
  final String productName;
  final String productImage;
  final int productPrice;
  final String productId;
  final String product_unit;
  final String product_description;
  ProductOverview(
      {required this.productId,
      required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.product_unit,
      required this.product_description});

  @override
  _ProductOverviewState createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  SinginCharacter _character = SinginCharacter.fill;

  Widget bonntonNavigatorBar({
    required Color iconColor,
    required Color backgroundColor,
    required Color color,
    required String title,
    required IconData iconData,
    required GestureTapCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(20),
          color: backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 20,
                color: iconColor,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                title,
                style: TextStyle(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool wishListBool = false;



  void _showCartDetails(
    BuildContext context,
    final String productName,
    final String productImage,
    final int productPrice,
    final String productId,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: 400,
          child: Column(
            children: [
              SingleItem(
                  productQuantity: 1,
                  productId: productId,
                  isBool: true,
                  productImage: productImage,
                  productName: productName,
                  productPrice: productPrice,
                  wishList: false),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // WishListProvider wishListProvider = Provider.of(context);
    // getWishtListBool();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chi tiết sản phẩm",
          style: TextStyle(color: textColor, fontSize: 17),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          bonntonNavigatorBar(
              backgroundColor: textColor,
              color: Colors.white70,
              iconColor: Colors.grey,
              title: "Thêm vào yêu thích",
              iconData: wishListBool == false
                  ? Icons.favorite_outline
                  : Icons.favorite,
              onTap: () {
                // setState(() {
                //   wishListBool = !wishListBool;
                // });
                // if (wishListBool == true) {
                //   wishListProvider.addWishListData(
                //     wishListId: widget.productId,
                //     wishListImage: widget.productImage,
                //     wishListName: widget.productName,
                //     wishListPrice: widget.productPrice,
                //     wishListQuantity: 2,

                //   );
                // } else {
                //   wishListProvider.deleteWishtList(widget.productId);
                // }
              }),
          bonntonNavigatorBar(
              backgroundColor: primaryColor,
              color: textColor,
              iconColor: Colors.white70,
              title: "Thêm vào giỏ hàng",
              iconData: Icons.shop_outlined,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ReviewCart(),
                  ),
                );
                // _showCartDetails(context, widget.productName,
                //     widget.productImage, widget.productPrice, widget.productId);
              })
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 1),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 250,
                          padding: EdgeInsets.all(40),
                          child: CachedNetworkImage(
                            imageUrl: widget.productImage,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            width: double.infinity, // Chiều rộng của ảnh
                            height: 230, // Chiều cao của ảnh
                            fit: BoxFit.fill, // Cách thức hiển thị ảnh
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            "Thông tin sản phẩm",
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(5),
                          child: Text(
                            widget.productName,
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          width: double.infinity,
                          child: Text(
                            "Giá bán",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 3,
                                    backgroundColor: Colors.green[700],
                                  ),
                                  Radio(
                                    value: SinginCharacter.fill,
                                    groupValue: _character,
                                    activeColor: Colors.green[700],
                                    onChanged: (value) {
                                      setState(() {
                                        _character = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Text(
                                NumberFormat.currency(
                                  symbol: 'VND',
                                  decimalDigits: 0,
                                  locale: 'vi_VN',
                                ).format(widget.productPrice),
                                style: AppTheme.kCardTitle,
                              ),
                              Count(
                                productId: widget.productId,
                                productImage: widget.productImage,
                                productName: widget.productName,
                                productPrice: widget.productPrice,
                                productUnit: '500 Gram',
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.transparent,
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 237, 236, 236)
                                    .withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          width: double.infinity,
                          height: 85,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Trọng lượng"),
                                    Gap(5),
                                    Text("500g")
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Thương hiệu"),
                                    Gap(5),
                                    Text("CookyyFood")
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Xuất xứ"),
                                    Gap(5),
                                    Text("Cooky")
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: ListView(
                  children: [
                    Text(
                      "Mô tả:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${widget.product_description}",
                      style: TextStyle(
                        fontSize: 16,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
