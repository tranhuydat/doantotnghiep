import 'package:flutter/material.dart';

class Category_Card extends StatefulWidget {
  late final String image;
  late final String name;
  late final GestureTapCallback press;

  Category_Card({
    required this.image,
    required this.name,
    required this.press,
  });

  @override
  State<Category_Card> createState() => _Category_CardState();
}

class _Category_CardState extends State<Category_Card> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: Container(
        height: 80,
        width: 80,
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0, 3))
                  ]),
              child: Image.network(
                widget.image,
              ),
            ),
            SizedBox(height: 5),
            Text(widget.name, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
