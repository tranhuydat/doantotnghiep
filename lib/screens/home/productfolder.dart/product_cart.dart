import 'package:app_cooky/models/productmodel.dart';
import 'package:app_cooky/screens/cart/count.dart';
import 'package:app_cooky/utils/mycolors.dart';
import 'package:app_cooky/utils/product_uinit.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SingalProduct extends StatefulWidget {
  final String productImage;
  final String productName;
  final int productPrice;
  final GestureTapCallback onTap;
  final String productId;
  final String product_unit;
  final String product_description;
  final ProductModel? productUnit;

  SingalProduct(
      {required this.productId,
      required this.productImage,
      required this.productName,
      required this.onTap,
      required this.productPrice,
      required this.product_description,
      required this.product_unit,
      this.productUnit});

  @override
  _SingalProductState createState() => _SingalProductState();
}

class _SingalProductState extends State<SingalProduct> {
  var unitData;
  var firstValue;
  @override
  Widget build(BuildContext context) {
    //   widget.productUnit.productUnit.firstWhere((element) {
    //   setState(() {
    //     firstValue = element;
    //   });
    //   return true;
    // });

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            height: 245,
            width: 165,
            decoration: BoxDecoration(
              color: Color(0xffd9dad9),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 2),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: widget.onTap,
                  child: Container(
                    height: 150,
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    child: Image.network(
                      widget.productImage,
                    ),
                  ),
                ), //-------------------------
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    // child: Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text(
                    //       widget.productName,
                    //       style: TextStyle(
                    //         color: Colors.black,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),

                    
                    //     Text(
                    //       '${widget.productPrice}\$/${unitData == null ? firstValue : unitData}',
                    //       style: TextStyle(
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       height: 5,
                    //     ),
                    //   ],
                    // ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.productName,
                              style: AppTheme.kCardTitle,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${widget.product_unit}',
                              style: AppTheme.kBodyText,
                            ),

                            Text(
                              NumberFormat.currency(
                                symbol: 'VND',
                                decimalDigits: 0,
                                locale: 'vi_VN',
                              ).format(widget.productPrice),
                              style: AppTheme.kCardTitle,
                            ),
                            // IconButton(
                            //     onPressed: () {},
                            //     icon: Icon(
                            //       Icons.shopping_cart,
                            //       size: 4,
                            //     ))

                            Row(
                              children: [
                                Expanded(
                                  child: ProductUnit(
                                    onTap: () {
                                      // showModalBottomSheet(
                                      //     context: context,
                                      //     builder: (context) {
                                      //       return Column(
                                      //         mainAxisSize: MainAxisSize.min,
                                      //         crossAxisAlignment:
                                      //             CrossAxisAlignment.start,
                                      //         children: widget
                                      //             .productUnit?.productUnit
                                      //             .map<Widget>((data) {
                                      //           return Column(
                                      //             children: [
                                      //               Padding(
                                      //                 padding: const EdgeInsets
                                      //                         .symmetric(
                                      //                     vertical: 10,
                                      //                     horizontal: 10),
                                      //                 child: InkWell(
                                      //                   onTap: () async {
                                      //                     setState(() {
                                      //                       unitData = data;
                                      //                     });
                                      //                     Navigator.of(context)
                                      //                         .pop();
                                      //                   },
                                      //                   child: Text(
                                      //                     data,
                                      //                     style: TextStyle(
                                      //                         color: primaryColor,
                                      //                         fontSize: 18),
                                      //                   ),
                                      //                 ),
                                      //               ),
                                      //             ],
                                      //           );
                                      //         }).toList(),
                                      //   );
                                      // });
                                    },
                                    title: "10%",
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Count(
                                  productId: widget.productId,
                                  productImage: widget.productImage,
                                  productName: widget.productName,
                                  productPrice: widget.productPrice,
                                  productUnit:
                                      unitData == null ? firstValue : unitData,
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
