import 'package:app_cooky/providers/category.dart';
import 'package:app_cooky/screens/home/category/categorycart.dart';
import 'package:app_cooky/screens/home/category/categoryshow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Category_Page extends StatefulWidget {
  //
  const Category_Page({super.key});

  @override
  State<Category_Page> createState() => _Category_PageState();
}

class _Category_PageState extends State<Category_Page> {
  late CategoryProvider categoryProvider;
  @override
  void initState() {
    CategoryProvider categoryProvider = Provider.of(context, listen: false);

    categoryProvider.fatchCategoriestData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    categoryProvider = Provider.of(context);
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: 200,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: categoryProvider.getCategoryDataList.map((categodata) {
              // categoryProvider.getCategoryData(categodata.name);
              // List<ProductModel> newlistprod = [];
              // newlistprod = categoryProvider.getProduct_Cate;
              return Category_Card(
                image: categodata.image,
                name: categodata.name,
                press: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CategoryShow(
                        query: categodata.name,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
