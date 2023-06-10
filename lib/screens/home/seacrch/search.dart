import 'package:app_cooky/models/productmodel.dart';
import 'package:app_cooky/providers/product_provider.dart';

import 'package:app_cooky/screens/home/productfolder.dart/product_cart.dart';
import 'package:app_cooky/screens/home/productfolder.dart/product_overview.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  final List<ProductModel> search;
  Search({required this.search});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query = "";
  late ProductProvider productProvider;

  searchItem(String query) {
    List<ProductModel> searchFood = widget.search.where((element) {
      return element.name.toLowerCase().contains(query);
    }).toList();
    return searchFood;
  }

  @override
  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.fatchHerbsProductData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    List<ProductModel> _searchItem = searchItem(query);
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.sort),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Gap(10),
              Container(
                height: 52,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      query = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Nhập tên sản phẩm bạn cần tìm",
                    hintStyle: TextStyle(color: Colors.black),
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                constraints: BoxConstraints(
                    maxHeight: double.infinity, maxWidth: double.infinity),
                child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
                    shrinkWrap: true,
                    primary: false,
                    itemCount: _searchItem.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            childAspectRatio: 0.7,
                            crossAxisCount: 2),
                    itemBuilder: ((context, index) {
                      ProductModel singleProduct = _searchItem[index];
                      return SingalProduct(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProductOverview(
                                    productId: singleProduct.id,
                                    product_description:
                                        singleProduct.product_description,
                                    product_unit: singleProduct.product_unit,
                                    productImage: singleProduct.image,
                                    productName: singleProduct.name,
                                    productPrice:
                                        int.parse(singleProduct.price)),
                              ),
                            );
                          },
                          productId: singleProduct.id,
                          product_description:
                              singleProduct.product_description,
                          product_unit: singleProduct.product_unit,
                          productImage: singleProduct.image,
                          productName: singleProduct.name,
                          productUnit: _searchItem[index],
                          productPrice: int.parse(singleProduct.price));
                    })),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
