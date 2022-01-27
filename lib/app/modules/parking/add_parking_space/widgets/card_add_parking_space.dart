import 'package:flutter/material.dart';

class CardAddParkingSpace extends StatelessWidget {
  const CardAddParkingSpace(
      {Key? key,
      required this.imageAsset,
      required this.title,
      required this.totalSpaces,
      required this.onTapAdd,
      required this.onTapRemove})
      : super(key: key);

  final String imageAsset;
  final String title;
  final int totalSpaces;
  final Function onTapAdd;
  final Function onTapRemove;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        Column(
          children: [
            Text(
              "Total",
              style: TextStyle(fontSize: width * 0.035),
            ),
            Text(
              "$totalSpaces",
              style: TextStyle(
                fontSize: width * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              tooltip: "Criar vaga livre",
              onPressed: () => onTapAdd(),
              icon: const Icon(
                Icons.add_circle_outline_rounded,
              ),
            ),
            IconButton(
              tooltip: "Remover vaga livre",
              onPressed: () => onTapRemove(),
              icon: const Icon(
                Icons.remove_circle_outline_rounded,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
