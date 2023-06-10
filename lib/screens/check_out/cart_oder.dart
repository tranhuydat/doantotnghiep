import 'package:app_cooky/models/cart_preview.dart';
import 'package:app_cooky/utils/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  final ReviewCartModel e;
  OrderItem({required this.e});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        e.cartImage,
        width: 60,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            e.cartName,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          Text(
            e.cartUnit,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          Text(
            NumberFormat.currency(
              symbol: 'VND',
              decimalDigits: 0,
              locale: 'vi_VN',
            ).format(e.cartPrice),
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          )
        ],
      ),
      subtitle: Text(e.cartQuantity.toString()),
    );
  }
}
