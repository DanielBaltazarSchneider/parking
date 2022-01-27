import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/app/data/enuns/vehicle_type.dart';
import 'package:parking/app/data/extensions/app_date_time.dart';
import 'package:parking/app/data/models/parking_space.dart';
import 'package:parking/app/data/packages/navigation/Nav.dart';

import 'list_all_parking_spaces_controller.dart';

class ListAllParkingSpacesView extends StatelessWidget {
  const ListAllParkingSpacesView({Key? key, required this.listParkingSpace}) : super(key: key);

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
    final ListAllParkingSpacesViewController _controller = Get.put(ListAllParkingSpacesViewController(listParkingSpace));

    return Scaffold(
      appBar: AppBar(
          title: Text("Vagas"),
          leading: InkWell(
            onTap: () => Nav.back(context: context),
            child: const Icon(Icons.keyboard_arrow_left_sharp),
          )),
      body: Column(
        children: [
          Text("Para reordenar as vagas, segure e arraste"),
          Expanded(
            child: GetBuilder<ListAllParkingSpacesViewController>(builder: (_) {
              return ReorderableListView(
                children: <Widget>[
                  for (int i = 0; i < _.listParkingSpace.length; i++)
                    ListTile(
                      key: Key('$i'),
                      title: Stack(
                        children: [
                          Column(
                            children: [
                              SizedBox(
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
                                              quarterTurns: _.listParkingSpace[i].register == null ? 1 : 0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(_.listParkingSpace[i].register == null
                                                        ? assetTopImageFromSizeVehicle(_.listParkingSpace[i].vehicleType)
                                                        : assetImageFromSizeVehicle(_.listParkingSpace[i].vehicleType)),
                                                    fit: BoxFit.contain,
                                                  ),
                                                  // color: _.listParkingSpace[i].register == null ? Colors.grey : Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (_.listParkingSpace[i].register != null) ...[
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
                                                        _.listParkingSpace[i].register?.vehicle.model ?? "",
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
                                                        _.listParkingSpace[i].register?.vehicle.licensePlate?.toUpperCase() ?? "",
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
                                                        _.listParkingSpace[i].register?.entryDateTime.toFormat_hh_mm() ?? "",
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
                              Divider(),
                            ],
                          ),
                          Visibility(
                            visible: _.listParkingSpace[i].register == null,
                            child: Container(
                              height: width * 0.2,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          )
                        ],
                      ),
                    ),
                ],
                onReorder: (int oldIndex, int newIndex) => _controller.reorderList(oldIndex, newIndex),
              );
            }),
          ),
        ],
      ),
    );
  }
}
