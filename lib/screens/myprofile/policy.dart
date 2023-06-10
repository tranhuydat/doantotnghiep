import 'package:flutter/material.dart';

class Policy extends StatefulWidget {
  const Policy({super.key});

  @override
  State<Policy> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Policy> {
  String a =
      "Thông tin được cung cấp tại COOKY có thể chứa thông tin từ bên thứ ba hoặc được chọn lọc từ các nguồn khác. Chúng tôi không chấp nhận bất cứ trách nhiệm nào về các thông tin mà chúng tôi đăng tải, bạn sẽ sử dụng hoặc đặt niềm tin vào những thông tin đó với hiểu biết, trách nhiệm và nguy cơ của riêng bạn.";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: Center(child: Text(a)),
    ));
  }
}
