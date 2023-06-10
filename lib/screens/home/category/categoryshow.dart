// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_cooky/providers/product_provider.dart';
import 'package:app_cooky/screens/home/category/category_p.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_cooky/models/productmodel.dart';
import 'package:app_cooky/providers/category.dart';
import 'package:app_cooky/screens/home/productfolder.dart/product_cart.dart';

class CategoryShow extends StatefulWidget {
  final String query;

  CategoryShow({Key? key, required this.query}) : super(key: key);

  @override
  State<CategoryShow> createState() => _CategoryShowState();
}

class _CategoryShowState extends State<CategoryShow> {
  late CategoryProvider categoryProvider;
  late ProductProvider productProvider;

  //33
  @override
  void initState() {
    categoryProvider = Provider.of(context, listen: false);

    categoryProvider.getCategoryData(widget.query);
    productProvider = Provider.of(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    categoryProvider = Provider.of(context);
    productProvider = Provider.of(context);

    List<ProductModel> newlistproduct = categoryProvider.getProduct_Cate;

    // newlistproduct = categoryProvider.getProduct_Cate;
    //--

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.query,
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(
              maxHeight: double.infinity, maxWidth: double.infinity),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                "Các sản phẩm khác",
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
            Category_Page(),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                "Sản phẩm",
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
            GridView.builder(
                padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
                shrinkWrap: true,
                primary: false,
                itemCount: newlistproduct.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.7,
                    crossAxisCount: 2),
                itemBuilder: ((context, index) {
                  ProductModel singleProduct = newlistproduct[index];
                  return SingalProduct(
                      onTap: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => ProductOverview(
                        //         productId: "44",
                        //         productImage: singleProduct.image,
                        //         productName: singleProduct.name,
                        //         productPrice: int.parse(singleProduct.price)),
                        //   ),
                        // );
                      },
                      productId: singleProduct.id,
                      product_unit: singleProduct.product_unit,
                      product_description: singleProduct.product_description,
                      productImage: singleProduct.image,
                      productUnit: newlistproduct[index],
                      productName: singleProduct.name,
                      productPrice: int.parse(singleProduct.price));
                })),
          ]),
        ),
      ),
    );
  }
}
