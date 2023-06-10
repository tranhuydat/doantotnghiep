import 'package:app_cooky/providers/deliver_provider.dart';
import 'package:app_cooky/screens/delivery/googlemap.dart';
import 'package:app_cooky/utils/custom_text_feld.dart';
import 'package:app_cooky/utils/mycolors.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AddDeliverAddress extends StatefulWidget {
  @override
  _AddDeliverAddressState createState() => _AddDeliverAddressState();
}

enum AddressTypes {
  Home,
  Work,
  Other,
}

class _AddDeliverAddressState extends State<AddDeliverAddress> {
  var myType = AddressTypes.Home;
  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);
    checkoutProvider.getCurrentLocation();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thêm địa chỉ vận chuyển",
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 48,
        child: checkoutProvider.isloadding == false
            ? MaterialButton(
                onPressed: () {
                  checkoutProvider.validator(context, myType);
                },
                child: Text(
                  "Thêm địa chỉ",
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
                color: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListView(
          children: [
            CostomTextField(
              labText: "Tên",
              controller: checkoutProvider.name,
            ),
            CostomTextField(
              labText: "Số điện thoại",
              controller: checkoutProvider.mobileNo,
            ),
            CostomTextField(
              labText: "Email",
              controller: checkoutProvider.alternateMobileNo,
            ),
            CostomTextField(
              labText: "Số nhà",
              controller: checkoutProvider.scoiety,
            ),
            CostomTextField(
              labText: "Đường",
              controller: checkoutProvider.street,
            ),
            CostomTextField(
              labText: "Phường",
              controller: checkoutProvider.landmark,
            ),
            CostomTextField(
              labText: "Huyện",
              controller: checkoutProvider.city,
            ),
            CostomTextField(
              labText: "Tỉnh",
              controller: checkoutProvider.aera,
            ),

            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CostomGoogleMap(),
                  ),
                );
              },
              child: Container(
                height: 47,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    checkoutProvider.setvitri == null
                        ? Text("Set Loaction")
                        : Text("Done!"),
                  ],
                ),
              ),
            ),
            // Divider(
            //   color: Colors.black,
            // ),
            // ListTile(
            //   title: Text("Address Type*"),
            // ),
            // RadioListTile(
            //   value: AddressTypes.Home,
            //   groupValue: myType,
            //   title: Text("Home"),
            //   onChanged: dd,
            //   // onChanged: (AddressTypes value) {
            //   //   setState(() {
            //   //     myType = value;
            //   //   });
            //   // },
            //   secondary: Icon(
            //     Icons.home,
            //     color: primaryColor,
            //   ),
            // ),
            // RadioListTile(
            //   value: AddressTypes.Work,
            //   groupValue: myType,
            //   title: Text("Work"),
            //   onChanged: (AddressTypes value) {
            //     setState(() {
            //       myType = value;
            //     });
            //   },
            //   secondary: Icon(
            //     Icons.work,
            //     color: primaryColor,
            //   ),
            // ),
            // RadioListTile(
            //   value: AddressTypes.Other,
            //   groupValue: myType,
            //   title: Text("Other"),
            //   onChanged: (AddressTypes value) {
            //     setState(() {
            //       myType = value;
            //     });
            //   },
            //   secondary: Icon(
            //     Icons.devices_other,
            //     color: primaryColor,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
