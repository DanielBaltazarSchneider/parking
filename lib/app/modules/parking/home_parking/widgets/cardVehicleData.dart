import 'package:flutter/material.dart';

class CardVehicleData extends StatelessWidget {
  const CardVehicleData(
      {Key? key,
      required this.assetImage,
      this.shadowColor,
      this.elevation,
      this.color,
      required this.available,
      required this.total,
      required this.unavailable})
      : super(key: key);

  final String assetImage;
  final Color? shadowColor;
  final double? elevation;
  final Color? color;
  final int available;
  final int total;
  final int unavailable;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      shadowColor: shadowColor ?? Colors.amber,
      child: Container(
        padding: const EdgeInsets.all(2),
        color: color ?? Colors.grey.shade50,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(
                assetImage,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ColumnVehicleData(
                    title: "Disponível",
                    value: "$available",
                  ),
                  _ColumnVehicleData(
                    title: "Ocupadas",
                    value: "$unavailable",
                  ),
                  _ColumnVehicleData(
                    title: "Total",
                    value: "$total",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ColumnVehicleData extends StatelessWidget {
  const _ColumnVehicleData({Key? key, required this.title, required this.value}) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        children: [
          Text(
            "$title: ",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
