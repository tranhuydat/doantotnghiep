import 'package:app_cooky/models/productmodel.dart';
import 'package:app_cooky/providers/product_provider.dart';
import 'package:app_cooky/screens/home/productfolder.dart/product_cart.dart';
import 'package:app_cooky/screens/home/productfolder.dart/product_overview.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Product_page extends StatefulWidget {
  @override
  State<Product_page> createState() => _Product_pageState();
}

class _Product_pageState extends State<Product_page> {
  late ProductProvider productProvider;

  @override
  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.fatchHerbsProductData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    List<ProductModel> ad = productProvider.getHerbsProductDataList;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints(
              maxHeight: double.infinity, maxWidth: double.infinity),
          // scrollDirection: Axis.horizontal,
          // child: Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children:
          //       productProvider.getHerbsProductDataList.map((herbproductdata) {
          //     return SingalProduct(
          //         productId: "1",
          //         productImage: herbproductdata.image,
          //         productName: herbproductdata.name,
          //         productPrice: int.parse(herbproductdata.price));
          //   }).toList(),

          // child: GridView.count(
          //   shrinkWrap: true,
          //   crossAxisCount: 2,

          //   children:
          //       productProvider.getHerbsProductDataList.map((herbsProductData) {
          //     return SingalProduct(
          //         // onTap: () {
          //         //   Navigator.of(context).push(
          //         //     MaterialPageRoute(
          //         //       builder: (context) => ProductOverview(
          //         //         productId: herbsProductData.productId,
          //         //         productPrice: herbsProductData.productPrice,
          //         //         productName: herbsProductData.productName,
          //         //         productImage: herbsProductData.productImage,
          //         //       ),
          //         //     ),
          //         //   );
          //         // },
          //         productId: "1",
          //         productImage: herbsProductData.image,
          //         productName: herbsProductData.name,
          //         productPrice: int.parse(herbsProductData.price));
          //   }).toList(),
          child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(20, 5, 0, 2),
              shrinkWrap: true,
              primary: false,
              itemCount: ad.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.7,
                  crossAxisCount: 2),
              itemBuilder: ((context, index) {
                ProductModel singleProduct = ad[index];
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
                            productPrice: int.parse(singleProduct.price),
                          ),
                        ),
                      );
                    },
                    productId: singleProduct.id,
                    product_description: singleProduct.product_description,
                    product_unit: singleProduct.product_unit,
                    productImage: singleProduct.image,
                    productName: singleProduct.name,
                    productUnit: ad[index],
                    productPrice: int.parse(singleProduct.price));
              }))),
    );
  }
}
