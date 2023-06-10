import 'package:app_cooky/models/usermodel.dart';
import 'package:app_cooky/myfolder/history.dart';
import 'package:app_cooky/myfolder/mydelivery_provider.dart';

import 'package:app_cooky/providers/user_provider.dart';
import 'package:app_cooky/screens/delivery/deliverydetail.dart';
import 'package:app_cooky/screens/myprofile/policy.dart';

import 'package:app_cooky/utils/mycolors.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    UserProvider userProvider = Provider.of(context, listen: false);
    userProvider.getUserData();
    HTProvider htProvider = Provider.of(context, listen: false);
    htProvider.getPlaceOrderData();

    super.initState();
  }

  late UserModel userModel;
  @override
  Widget listTile(
      {required IconData icon,
      required String title,
      GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Divider(
            height: 1,
          ),
          ListTile(
            leading: Icon(icon),
            title: Text(title),
            trailing: Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();
    UserModel userData = userProvider.getcurrentUserData;

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 100,
                  color: primaryColor,
                ),
                Container(
                  height: 548,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 250,
                            height: 80,
                            padding: EdgeInsets.only(left: 20),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        userData.userName,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: textColor),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(userData.userEmail),
                                    ],
                                  ),
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: primaryColor,
                                    child: CircleAvatar(
                                      radius: 12,
                                      child: Icon(
                                        Icons.edit,
                                        color: primaryColor,
                                      ),
                                      backgroundColor: scaffoldBackgroundColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      listTile(
                        icon: Icons.shop_outlined,
                        title: "Đơn hàng",
                        onTap: () async {
                          await Future.delayed(Duration(seconds: 2));
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MyHistory(),
                            ),
                          );
                        },
                      ),
                      listTile(
                        icon: Icons.location_on_outlined,
                        title: "Địa chỉ",
                        onTap: () async {
                          await Future.delayed(Duration(seconds: 2));
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DeliveryDetails(),
                            ),
                          );
                        },
                      ),
                      listTile(
                        icon: Icons.settings,
                        title: "Sửa thông tin",
                        onTap: () async {
                          await Future.delayed(Duration(seconds: 2));
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Policy(),
                            ),
                          );
                        },
                      ),
                      listTile(icon: Icons.favorite, title: "Yêu thích"),
                      listTile(
                          icon: Icons.policy_outlined,
                          title: "Chính sách",
                          onTap: () async {
                            await Future.delayed(Duration(seconds: 2));
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Policy(),
                              ),
                            );
                          }),
                      listTile(
                          icon: Icons.add_chart,
                          title: "Khác",
                          onTap: () async {
                            await Future.delayed(Duration(seconds: 2));
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Policy(),
                              ),
                            );
                          }),
                      listTile(
                          icon: Icons.exit_to_app_outlined, title: "Đăng xuất"),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 30),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: primaryColor,
                child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      userData.userImage ??
                          "https://img.freepik.com/premium-vector/healthy-food-logo_476121-95.jpg?w=2000",
                    ),
                    radius: 45,
                    backgroundColor: scaffoldBackgroundColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
