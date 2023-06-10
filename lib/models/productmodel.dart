// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProductModel {
  String id;
  String name;
  String price;
  String image;
  String product_unit;
  String product_description;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.product_unit,
    required this.product_description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'product_unit': product_unit,
      'product_description': product_description,
    };
  }

  // factory ProductModel.fromMap(Map<String, dynamic> map) {
  //   return ProductModel(
  //     id: map['id'] != null ? map['id'] as String : null,
  //     name: map['name'] as String,
  //     price: map['price'] as String,
  //     image: map['image'] as String,
  //     product_unit: map['product_unit'] as String,
  //     product_description: map['product_description'] as String,
  //   );
  // }
}
