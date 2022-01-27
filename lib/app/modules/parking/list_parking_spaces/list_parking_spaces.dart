import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/app/data/enuns/vehicle_type.dart';
import 'package:parking/app/data/extensions/app_date_time.dart';
import 'package:parking/app/data/models/parking_space.dart';
import 'package:parking/app/data/packages/navigation/Nav.dart';
import 'package:parking/app/modules/parking/list_parking_spaces/list_parking_spaces_controller.dart';

class ListParkingSpaces extends StatelessWidget {
  const ListParkingSpaces({Key? key, required this.listParkingSpace}) : super(key: key);

  final List<ParkingSpace> listParkingSpace;

  String assetImageFromSizeVehicle(vehicleType) {
    return vehicleType == VehicleType.small
        ? "assets/images/car1_in.png"
        : vehicleType == VehicleType.medium
            ? "assets/images/car2_in.png"
            : "assets/images/car3_in.png";
  }

  String assetTopImageFromSizeVehicle(vehicleType) {
    return vehicleType == VehicleType.small
        ? "assets/images/top_small.png"
        : vehicleType == VehicleType.medium
            ? "assets/images/top_medium.png"
            : "assets/images/top_big.png";
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final ListParkingSpacesController _controller = Get.put(ListParkingSpacesController());

    return Scaffold(
      appBar: AppBar(
          title: Text("Escolha a vaga"),
          leading: InkWell(
            onTap: () => Nav.back(context: context),
            child: const Icon(Icons.keyboard_arrow_left_sharp),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < listParkingSpace.length; i++) ...[
              Stack(
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () => listParkingSpace[i].register != null
                            ? _controller.selectParkingSpace(context, index: i, register: listParkingSpace[i].register!)
                            : null,
                        child: SizedBox(
                          height: width * 0.2,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Center(child: Text("${i + 1}")),
                              ),
                              Expanded(
                                flex: 5,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: RotatedBox(
                                        quarterTurns: listParkingSpace[i].register == null ? 1 : 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(listParkingSpace[i].register == null
                                                  ? assetTopImageFromSizeVehicle(listParkingSpace[i].vehicleType)
                                                  : assetImageFromSizeVehicle(listParkingSpace[i].vehicleType)),
                                              fit: BoxFit.contain,
                                            ),
                                            // color: listParkingSpace[i].register == null ? Colors.grey : Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (listParkingSpace[i].register != null) ...[
                                      SizedBox(
                                        width: width * 0.45,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Modelo: ",
                                                  style: TextStyle(fontSize: width * 0.035),
                                                ),
                                                Text(
                                                  listParkingSpace[i].register?.vehicle.model ?? "",
                                                  style: TextStyle(
                                                    fontSize: width * 0.035,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Placa: ",
                                                  style: TextStyle(fontSize: width * 0.035),
                                                ),
                                                Text(
                                                  listParkingSpace[i].register?.vehicle.licensePlate?.toUpperCase() ?? "",
                                                  style: TextStyle(
                                                    fontSize: width * 0.035,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Entrada: ",
                                                  style: TextStyle(fontSize: width * 0.035),
                                                ),
                                                Text(
                                                  listParkingSpace[i].register?.entryDateTime.toFormat_hh_mm() ?? "",
                                                  style: TextStyle(
                                                    fontSize: width * 0.035,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                  Visibility(
                    visible: listParkingSpace[i].register == null,
                    child: Container(
                      height: width * 0.2,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  )
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
