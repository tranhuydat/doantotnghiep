import 'package:app_cooky/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  void addUserData({
    User? currentUser,
    String? userName,
    String? userImage,
    String? userEmail,
  }) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser?.uid)
        .set(
      {
        "name": userName,
        "email": userEmail,
        "profilepic": userImage,
        "userUid": currentUser?.uid,
      },
    );
  }

  late UserModel currentData;

  void getUserData() async {
    UserModel userModel;
    var value = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (value.exists) {
      userModel = UserModel(
        userEmail: value.get("email"),
        userImage: value.get("profilepic"),
        userName: value.get("name"),
        userUid: value.get("userUid"),
      );
      currentData = userModel;
      notifyListeners();
    }
  }

  UserModel get getcurrentUserData {
    return currentData;
  }
}
