import 'package:app_cooky/models/productmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> herbsProductList = [];
  List<int> listdiscount = [];

  late ProductModel productModel;
  fatchHerbsProductData() async {
    List<ProductModel> newlistproduct = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("Products").get();
    value.docs.forEach(
      (element) {
        productModel = ProductModel(
          id: element.id,
          name: element.get("name"),
          price: element.get("price").toString(),
          image: element.get("image"),
          product_unit: element.get("unit"),
          product_description: element.get("description"),
        );

        newlistproduct.add(productModel);
      },
    );
    herbsProductList = newlistproduct;
    notifyListeners();
  }

  List<ProductModel> get getHerbsProductDataList {
    return herbsProductList;
  }

  //-----------------------search
  List<ProductModel> search = [];
  productModels(QueryDocumentSnapshot element) {
    productModel = ProductModel(
        id: element.id,
        name: element.get("name"),
        price: element.get("price").toString(),
        image: element.get("image"),
        product_description: element.get("description"),
        product_unit: element.get("unit"));
    search.add(productModel);
    notifyListeners();
  }

  List<ProductModel> get gerAllProductSearch {
    return search;
  }

  getdiscout() async {
    List<int> discount = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("dicout").get();
    value.docs.forEach(
      (element) {
        discount.add(element.get("persent"));
      },
    );
    listdiscount = discount;
    notifyListeners();
  }

  List<int> get getdiscoutdata {
    return listdiscount;
  }
}
