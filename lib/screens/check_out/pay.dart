import 'package:app_cooky/models/deli_addressmodel.dart';
import 'package:app_cooky/providers/deliver_provider.dart';
import 'package:app_cooky/providers/review_cart_provider.dart';
import 'package:app_cooky/screens/check_out/cart_oder.dart';
import 'package:app_cooky/screens/delivery/deliverysingle.dart';
import 'package:app_cooky/screens/loadcreens.dart';
import 'package:app_cooky/utils/mycolors.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

class PaymentSummary extends StatefulWidget {
  final DeliveryAddressModel deliverAddressList;
  PaymentSummary({required this.deliverAddressList});

  @override
  _PaymentSummaryState createState() => _PaymentSummaryState();
}

enum AddressTypes {
  Home,
  OnlinePayment,
}

class _PaymentSummaryState extends State<PaymentSummary> {
  var myType = AddressTypes.Home;

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    CheckoutProvider checkoutProvider = Provider.of(context);

    double discount = 0;
    double? discountValue;

    double? total;
    double totalPrice = reviewCartProvider.getTotalPrice();

    if (totalPrice > 300000) {
      discount = 10;
      discountValue = (totalPrice * discount) / 100;
      total = totalPrice - discountValue;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chi tiết đơn hàng",
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: ListTile(
        title: Text("Tổng tiền hóa đơn"),
        subtitle: Text(
          NumberFormat.currency(
            symbol: 'VND',
            decimalDigits: 0,
            locale: 'vi_VN',
          ).format(total ?? totalPrice),
          style: TextStyle(
            color: Colors.green[900],
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        trailing: Container(
          width: 160,
          child: MaterialButton(
            onPressed: () {
              checkoutProvider.addPlaceOderData(
                  soluong: reviewCartProvider.getReviewCartDataList.length,
                  hinhthuc: myType.toString(),
                  total: total?.toInt() ?? totalPrice.toInt(),
                  oderItemList: reviewCartProvider.reviewCartDataList,
                  deliveryAddressModel: widget.deliverAddressList);

              //------------
              reviewCartProvider.deleteAllCart();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoadScreen()));
            },
            child: Text(
              "Xác nhận ",
              style: TextStyle(
                color: textColor,
              ),
            ),
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Text("Thông tin khách hàng"),
                SingleDeliveryItem(
                  address:
                      "Địa chỉ:${widget.deliverAddressList.street}-${widget.deliverAddressList.landMark}-${widget.deliverAddressList.city}",
                  title: "${widget.deliverAddressList.name} ",
                  number: widget.deliverAddressList.mobileNo,
                  addressType: widget.deliverAddressList.addressType ==
                          "AddressTypes.Home"
                      ? "Home"
                      : widget.deliverAddressList.addressType ==
                              "AddressTypes.Other"
                          ? "Other"
                          : "Work",
                ),
                Divider(),
                ExpansionTile(
                  children: reviewCartProvider.getReviewCartDataList.map((e) {
                    return OrderItem(
                      e: e,
                    );
                  }).toList(),
                  title: Text(
                      "Số lượng sản phẩm: ${reviewCartProvider.getReviewCartDataList.length}"),
                ),
                Divider(),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Tổng tiền:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    NumberFormat.currency(
                      symbol: 'VND',
                      decimalDigits: 0,
                      locale: 'vi_VN',
                    ).format(total ?? totalPrice),
                    style: AppTheme.kCardTitle,
                  ),
                ),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Discount:",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Text(
                    "$discount%",
                    style: AppTheme.kCardTitle,
                  ),
                ),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Số tiền giảm cho đơn>300.000Đ:",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Text(
                    NumberFormat.currency(
                      symbol: 'VND',
                      decimalDigits: 0,
                      locale: 'vi_VN',
                    ).format(discountValue ?? 0),
                    style: AppTheme.kCardTitle,
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Text("Phương thức thanh toán:"),
                ),
                RadioListTile(
                  value: AddressTypes.Home,
                  groupValue: myType,
                  title: Text("Trực tiếp"),
                  onChanged: (AddressTypes? value) {
                    setState(() {
                      myType = value!;
                    });
                  },
                  secondary: Icon(
                    Icons.work,
                    color: primaryColor,
                  ),
                ),
                RadioListTile(
                  value: AddressTypes.OnlinePayment,
                  groupValue: myType,
                  title: Text("Banking"),
                  onChanged: (AddressTypes? value) {
                    setState(() {
                      myType = value!;
                    });
                  },
                  secondary: Icon(
                    Icons.devices_other,
                    color: primaryColor,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
