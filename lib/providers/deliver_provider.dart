import 'package:app_cooky/models/cart_preview.dart';
import 'package:app_cooky/models/deli_addressmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart';

class CheckoutProvider with ChangeNotifier {
  bool isloadding = false;

  TextEditingController name = TextEditingController();

  TextEditingController mobileNo = TextEditingController();
  TextEditingController alternateMobileNo = TextEditingController();
  TextEditingController scoiety = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController aera = TextEditingController();
  TextEditingController pincode = TextEditingController();
  // late LocationData setLoaction;

  Position? setvitri;

  void validator(context, myType) async {
    if (name.text.isEmpty) {
      Fluttertoast.showToast(msg: "Vui lòng nhập tên");
    } else if (mobileNo.text.isEmpty) {
      Fluttertoast.showToast(msg: "Vui lòng nhập số điện thoại");
    } else if (alternateMobileNo.text.isEmpty) {
      Fluttertoast.showToast(msg: "Vui lòng nhập số nhà");
    } else if (scoiety.text.isEmpty) {
      Fluttertoast.showToast(msg: "Vui lòng nhập email");
    } else if (street.text.isEmpty) {
      Fluttertoast.showToast(msg: "Vui lòng nhập số đường");
    } else if (landmark.text.isEmpty) {
      Fluttertoast.showToast(msg: "Vui lòng nhập tên phường");
    } else if (city.text.isEmpty) {
      Fluttertoast.showToast(msg: "Vui lòng nhập tên huyện");
    } else if (aera.text.isEmpty) {
      Fluttertoast.showToast(msg: "Vui lòng nhập tên tỉnh");
    } else if (setvitri == null) {
      Fluttertoast.showToast(msg: "Nhập vị trí hiện tại");
    } else {
      isloadding = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("AddDeliverAddress")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        "name": name.text,
        "mobileNo": mobileNo.text,
        "alternateMobileNo": alternateMobileNo.text,
        "scoiety": scoiety.text,
        "street": street.text,
        "landmark": landmark.text,
        "city": city.text,
        "aera": aera.text,
        "addressType": myType.toString(),
        "longitude": setvitri?.longitude ?? "null",
        "latitude": setvitri?.latitude ?? "null",
      }).then((value) async {
        isloadding = false;
        notifyListeners();
        await Fluttertoast.showToast(msg: "Nhập địa chỉ của bạn");
        Navigator.of(context).pop();
        notifyListeners();
      });
      notifyListeners();
    }
  }

  List<Map<String, dynamic>> historylist = [];

  List<DeliveryAddressModel> deliveryAdressList = [];
  getDeliveryAddressData() async {
    List<DeliveryAddressModel> newList = [];

    DeliveryAddressModel deliveryAddressModel;
    DocumentSnapshot _db = await FirebaseFirestore.instance
        .collection("AddDeliverAddress")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (_db.exists) {
      deliveryAddressModel = DeliveryAddressModel(
        name: _db.get("name"),
        addressType: _db.get("addressType"),
        aera: _db.get("aera"),
        city: _db.get("city"),
        landMark: _db.get("landmark"),
        mobileNo: _db.get("mobileNo"),
        street: _db.get("street"),
      );
      newList.add(deliveryAddressModel);
      notifyListeners();
    }

    deliveryAdressList = newList;
    notifyListeners();
  }

  List<DeliveryAddressModel> get getDeliveryAddressList {
    return deliveryAdressList;
  }

  List<Map<String, dynamic>> get gethistorylist {
    return historylist;
  }

////// Order /////////

  addPlaceOderData(
      {required List<ReviewCartModel> oderItemList,
      required String hinhthuc,
      required int soluong,
      required int total,
      required DeliveryAddressModel deliveryAddressModel}) async {
    FirebaseFirestore.instance.collection("MyOrders").doc().set(
      {
        "name": deliveryAddressModel.name,
        "street": deliveryAddressModel.street,
        "landmark": deliveryAddressModel.landMark,
        "city": deliveryAddressModel.city,
        "area": deliveryAddressModel.aera,
        "phone": deliveryAddressModel.mobileNo,
        "confirm": false,
        "total": total,
        "iduser": FirebaseAuth.instance.currentUser?.uid,
        "hinhthuc": hinhthuc,
        "soluong": soluong,
        "orderTime": DateTime.now(),
        "orderItems": oderItemList
            .map((e) => {
                  "orderImage": e.cartImage,
                  "orderName": e.cartName,
                  "orderUnit": e.cartUnit,
                  "orderPrice": e.cartPrice,
                  "orderQuantity": e.cartQuantity
                })
            .toList(),
      },
    );
  }

  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setvitri = position;
    return position;
  }
}
