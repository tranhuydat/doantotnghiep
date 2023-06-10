import 'package:app_cooky/utils/mycolors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class Singe_His extends StatelessWidget {
  final String? name;
  final String? street;
  final String? area;
  final String? city;
  final String? phone;
  final Timestamp? date;
  final List<Map<String, dynamic>> listreview;
  final bool confirm;
  final int? total;
  final String? hinhthuc;
  final int index;

  Singe_His(
      {required this.name,
      required this.street,
      required this.area,
      required this.confirm,
      required this.city,
      required this.phone,
      required this.date,
      required this.listreview,
      required this.total,
      required this.hinhthuc,
      required this.index});
  @override
  Widget build(BuildContext context) {
    String trangthai = "Đăng chờ...";
    if (confirm) {
      trangthai = "Đang giao hàng";
    }
    DateTime ngaydat = date!.toDate();

    return SafeArea(
      child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
          child: Container(
            decoration: BoxDecoration(
              color: secondaryBackground,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Color(0xFFC9C9C9),
                  offset: Offset(0, 2),
                )
              ],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Color(0xFFC9C9C9),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: secondaryBackground,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Họ tên: ',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Colors.grey),
                          ),
                          Text(
                            "${name ?? "null"}",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 19,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(2),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: secondaryBackground,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Số điện thoại:',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Colors.grey),
                          ),
                          Text(
                            "$phone",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(2),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: secondaryBackground,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Địa chỉ nhận:',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Colors.grey),
                          ),
                          Text(
                            '$street-$area-$city',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(2),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: secondaryBackground,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Ngày đặt:',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Colors.grey),
                          ),
                          Text(
                            '${ngaydat.day}-${ngaydat.month}-${ngaydat.year}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(2),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: secondaryBackground,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Trạng thái: ',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Colors.grey),
                          ),
                          Checkbox(
                            value: confirm,
                            onChanged: (newValue) {},
                            activeColor: Colors.green, // màu khi true
                            checkColor: Colors.grey, // màu khi false
                          ),
                          Text(
                            '$trangthai',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(2),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: secondaryBackground,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Hình thức:',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Colors.grey),
                          ),
                          Text(
                            '$hinhthuc',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(2),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: secondaryBackground,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Tổng tiền:',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Colors.grey),
                          ),
                          Text(
                            NumberFormat.currency(
                              symbol: 'VND',
                              decimalDigits: 0,
                              locale: 'vi_VN',
                            ).format(total),
                            style: TextStyle(
                                color: textColor, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  Gap(2),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        width: double.infinity,
                        constraints: BoxConstraints(maxHeight: 200.0),
                        decoration: BoxDecoration(
                          color: secondaryBackground,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Chi tiết: ',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      itemCount: listreview[index]['orderItems']
                                          .length,
                                      itemBuilder: (context, subIndex) {
                                        return Column(
                                          children: [
                                            Text(
                                              '${listreview[index]['orderItems'][subIndex]['cartName']}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "Số lượng:${listreview[index]['orderItems'][subIndex]['cartQuantity']}",
                                              style: TextStyle(
                                                color: Colors.blue,
                                              ),
                                            ),
                                            Text(
                                              'Giá:${listreview[index]['orderItems'][subIndex]['cartPrice']}',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 10, 0),
                                              child: Divider(
                                                thickness: 1,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
