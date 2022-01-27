import 'package:flutter/material.dart';

class CardInputParkingSpace extends StatelessWidget {
  const CardInputParkingSpace({Key? key, required this.imageAsset, required this.title, this.controller}) : super(key: key);

  final String imageAsset;
  final String title;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              child: Image.asset(
                imageAsset,
                width: width * 0.13,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: width * 0.03,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        SizedBox(width: width * 0.2),
        SizedBox(
          width: width * 0.2,
          child: TextField(
            controller: controller,
            style: TextStyle(
              fontSize: width * 0.035,
            ),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              isDense: true,
              hintText: "Quantidade",
              contentPadding: EdgeInsets.only(bottom: 2),
            ),
          ),
        ),
      ],
    );
  }
}
