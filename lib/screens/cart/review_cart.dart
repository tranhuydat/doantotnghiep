import 'package:app_cooky/models/cart_preview.dart';
import 'package:app_cooky/providers/review_cart_provider.dart';
import 'package:app_cooky/screens/cart/singe_items.dart';
import 'package:app_cooky/screens/delivery/deliverydetail.dart';
import 'package:app_cooky/screens/delivery/googlemap.dart';
import 'package:app_cooky/screens/home/homepage.dart';
import 'package:app_cooky/utils/mycolors.dart';
import 'package:app_cooky/utils/mystring.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class ReviewCart extends StatefulWidget {
  ReviewCart({super.key});

  @override
  State<ReviewCart> createState() => _ReviewCartState();
}

class _ReviewCartState extends State<ReviewCart> {
  late ReviewCartProvider reviewCartProvider;

  showAlertDialog(BuildContext context, ReviewCartModel delete) {

    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        reviewCartProvider.reviewCartDataDelete(delete.cartId);
        Navigator.of(context).pop();
      },
    );

   
    AlertDialog alert = AlertDialog(
      title: Text("Cart Product"),
      content: Text("Are you devete on cartProduct?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    reviewCartProvider.getReviewCartData();

    return Scaffold(
      bottomNavigationBar: ListTile(
        title: Text("Tổng tiền"),
        subtitle: Text(
          NumberFormat.currency(
            symbol: 'VND',
            decimalDigits: 0,
            locale: 'vi_VN',
          ).format(reviewCartProvider.getTotalPrice()),
          style: AppTheme.kCardTitle,
        ),
        trailing: Container(
          width: 160,
          child: MaterialButton(
            child: Text("Đặt hàng"),
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                30,
              ),
            ),
            onPressed: () async {
              if (reviewCartProvider.getReviewCartDataList.isEmpty) {
                await Fluttertoast.showToast(msg: "No Cart Data Found");
                return;
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DeliveryDetails(),

                  //-------------------------
                ),
              );
            },
          ),
        ),
      ),
      // appBar: AppBar(
      //   title: Text(
      //     "Review Cart",
      //     style: TextStyle(color: textColor, fontSize: 18),
      //   ),
      // ),
      body: reviewCartProvider.getReviewCartDataList.isEmpty
          ? Center(
              child: Text("Không có sản phẩm nào"),
            )
          : ListView.builder(
              itemCount: reviewCartProvider.getReviewCartDataList.length,
              itemBuilder: (context, index) {
                ReviewCartModel data =
                    reviewCartProvider.getReviewCartDataList[index];

                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),

                    // SingleItem(
                    //   isBool: true,
                    //   wishList: false,
                    //   productImage: data.cartImage,
                    //   productName: data.cartName,
                    //   productPrice: data.cartPrice,
                    //   productId: data.cartId,
                    //   productQuantity: data.cartQuantity,
                    //   productUnit: data.cartUnit,
                    //   onDelete: () {
                    //     showAlertDialog(context, data);
                    //   },
                    // ),
                    Dismissible(
                      key: Key(data.cartId),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {
                          reviewCartProvider.reviewCartDataDelete(data.cartId);
                        });
                      },
                      background: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFE6E6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [Spacer(), Icon(Icons.delete)],
                        ),
                      ),
                      child: SingleItem(
                        isBool: true,
                        wishList: false,
                        productImage: data.cartImage,
                        productName: data.cartName,
                        productPrice: data.cartPrice,
                        productId: data.cartId,
                        productQuantity: data.cartQuantity,
                        productUnit: data.cartUnit,
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
