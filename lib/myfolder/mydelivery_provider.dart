import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HTProvider with ChangeNotifier {
  late List<Map<String, dynamic>> mylistht = [];

  Future<List<Map<String, dynamic>>> getPlaceOrderData() async {
    List<Map<String, dynamic>> newlist = [];

    // QuerySnapshot querySnapshot = await FirebaseFirestore.instance
    //     .collection("Order")
    //     .doc(FirebaseAuth.instance.currentUser?.uid)
    //     .collection("MyOrders")
    //     .get();

    // if (querySnapshot.size > 0) {
    //   // for (var documentSnapshot in querySnapshot.docs) {
    //   //   newlist.add({
    //   //     "name": documentSnapshot['name'],
    //   //     "street": documentSnapshot['street'],
    //   //     "landmark": documentSnapshot['landmark'],
    //   //     "city": documentSnapshot['city'],
    //   //     "area": documentSnapshot['area'],
    //   //     "phone": documentSnapshot['phone'],
    //   //     "confirm": documentSnapshot['confirm'],
    //   //     "orderItems": (documentSnapshot['orderItems'] as List<dynamic>)
    //   //         .map((item) => ReviewCartModel(
    //   //               cartId: 'item[id]',
    //   //               cartName: item['orderName'],
    //   //               cartImage: item['orderImage'],
    //   //               cartQuantity: item['orderQuantity'],
    //   //               cartPrice: item['orderPrice'],
    //   //               cartUnit: item['orderUnit'],
    //   //             ))
    //   //         .toList(),
    //   //   });
    //   // }
    //   querySnapshot.docs.forEach((element) {
    //     newlist.add({
    //       "name": element.get('name'),
    //       "street": element.get('street'),
    //       "landmark": element.get('landmark'),
    //       "city": element.get('city'),
    //       "area": element.get('area'),
    //       "phone": element.get('phone'),
    //       "confirm": element.get('confirm'),
    //       "orderItems": (element.get('orderItems') as List<dynamic>)
    //           .map((item) => Map<String,dynamic>(
    //                 'cartId': 'item[id]',
    //                 'cartName': item.get['orderName'],
    //                 'cartImage': item.get['orderImage'],
    //                 'cartQuantity': item.get['orderQuantity'],
    //                 'cartPrice': item.get['orderPrice'],
    //                 'cartUnit': item.get['orderUnit'],
    //               ))
    //     });
    //   });
    //   mylistht = newlist;
    //   return newlist;
    // } else {
    //   return newlist = [];
    // }

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("MyOrders")
        .where("iduser", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (querySnapshot.size > 0) {
      querySnapshot.docs.forEach((element) {
        List<Map<String, dynamic>> orderItemsList = [];
        (element.get('orderItems') as List<dynamic>).forEach((item) {
          Map<String, dynamic> map = {
            'cartId': item['id'],
            'cartName': item['orderName'],
            'cartImage': item['orderImage'],
            'cartQuantity': item['orderQuantity'],
            'cartPrice': item['orderPrice'],
            'cartUnit': item['orderUnit'],
          };
          orderItemsList.add(map);
        });

        newlist.add({
          "name": element.get('name'),
          "street": element.get('street'),
          "landmark": element.get('landmark'),
          "city": element.get('city'),
          "area": element.get('area'),
          "phone": element.get('phone'),
          "confirm": element.get('confirm'),
          "orderTime": element.get('orderTime'),
          "total": element.get('total').toString(),
          "hinhthuc": element.get('hinhthuc'),
          "orderItems": orderItemsList
        });
      });

      mylistht = newlist;
      notifyListeners();
      return newlist;
    } else {
      notifyListeners();
      return newlist = [];
    }
  }

  List<Map<String, dynamic>> get getdatalist {
    notifyListeners();
    return mylistht;
  }
}
