import 'package:app_cooky/myfolder/mydelivery_provider.dart';
import 'package:app_cooky/myfolder/singe_his.dart';
import 'package:app_cooky/utils/mycolors.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHistory extends StatefulWidget {
  const MyHistory({super.key});

  @override
  State<MyHistory> createState() => _MyHistoryState();
}

class _MyHistoryState extends State<MyHistory> {
  late List<Map<String, dynamic>> listhist = [];
  @override
  void initState() {
    HTProvider htProvider = Provider.of(context, listen: false);
    htProvider.getPlaceOrderData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HTProvider htProvider = Provider.of(context);
    listhist = htProvider.mylistht;

    return listhist.isEmpty
        ? Container(
            width: double.infinity,
            height: double.infinity,
            color: kPrimaryColor,
            child: Center(
              child: Text("Không có đơn hàng nào"),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("Lịch sử giao mua hàng"),
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
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: listhist.length,
                      itemBuilder: (context, index) {
                        return Singe_His(
                            name: listhist[index]['name'],
                            street: listhist[index]['street'],
                            area: listhist[index]['landmark'],
                            city: listhist[index]['city'],
                            phone: listhist[index]['phone'],
                            date: listhist[index]['orderTime'],
                            confirm: listhist[index]['confirm'],
                            listreview: listhist,
                            index: index,
                            total: int.parse(listhist[index]['total']),
                            hinhthuc: listhist[index]['hinhthuc']);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
