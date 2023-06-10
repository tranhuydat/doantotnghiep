import 'package:app_cooky/models/categoriesmodel.dart';
import 'package:app_cooky/models/productmodel.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> listcategory = [];
  List<ProductModel> productlist = [];

  late CategoryModel categoryModel;
  late ProductModel productModel;
  fatchCategoriestData() async {
    List<CategoryModel> newlistcategory = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("Category").get();
    value.docs.forEach(
      (element) {
        categoryModel = CategoryModel(
            name: element.get("name"), image: element.get("image"));
        newlistcategory.add(categoryModel);
      },
    );
    listcategory = newlistcategory;
    notifyListeners();
  }

  List<CategoryModel> get getCategoryDataList {
    return listcategory;
  }

  getCategoryData(String query) async {
    List<ProductModel> newlistprodut = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("Products")
        .where('category', isEqualTo: query)
        .get();
    value.docs.forEach(
      (element) {
        productModel = ProductModel(
            name: element.get("name"),
            image: element.get("image"),
            id: element.id,
            price: element.get("price").toString(),
            product_description: element.get("description"),
            product_unit: element.get("unit"));
        newlistprodut.add(productModel);
      },
    );
    productlist = newlistprodut;
    notifyListeners();
  }

  List<ProductModel> get getProduct_Cate {
    return productlist;
  }
}
/*
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

*/