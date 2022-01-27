import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/app/data/enuns/moviment.dart';
import 'package:parking/app/data/enuns/vehicle_type.dart';
import 'package:parking/app/data/extensions/app_date_time.dart';
import 'package:parking/app/data/models/historic.dart';
import 'package:parking/app/data/packages/navigation/Nav.dart';
import 'package:parking/app/modules/parking/historic/historic_controller.dart';

class HistoricView extends StatelessWidget {
  const HistoricView({Key? key, required this.historic}) : super(key: key);

  final Historic historic;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
        title: Text("Histórico"),
        leading: InkWell(
          onTap: () => Nav.back(context: context),
          child: const Icon(Icons.keyboard_arrow_left_sharp),
        ));
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top;
    final controller = Get.put(HistoricController(historic));

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.1,
              child: GetBuilder<HistoricController>(builder: (_) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < controller.listDates.length; i++) ...[
                        InkWell(
                          onTap: () => controller.selectDateTime(controller.listDates[i]),
                          child: Card(
                            color: controller.selectedDate == null
                                ? Colors.white
                                : controller.isEqualsDate(controller.listDates[i], controller.selectedDate!)
                                    ? Colors.grey
                                    : Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(width * 0.02),
                              child: Text(controller.listDates[i].toFormat_dd_MM_yyyy()),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }),
            ),
            SizedBox(
              height: height * 0.9,
              child: GetBuilder<HistoricController>(
                builder: (_) {
                  return ListView.separated(
                    separatorBuilder: (BuildContext context, int i) => const Divider(),
                    reverse: false,
                    itemCount: _.listRegisterFilter.length,
                    itemBuilder: (BuildContext context, int a) {
                      int i = (_.listRegisterFilter.length - 1) - a;
                      return Row(
                        children: [
                          // Text((i + 1).toString()),
                          SizedBox(width: width * 0.025),
                          Column(
                            children: [
                              Image.asset(
                                _.listRegisterFilter[i].vehicle.vehicleType == VehicleType.small
                                    ? "assets/images/car1_in.png"
                                    : _.listRegisterFilter[i].vehicle.vehicleType == VehicleType.medium
                                        ? "assets/images/car2_in.png"
                                        : "assets/images/car3_in.png",
                                width: width * 0.12,
                              ),
                              Text(
                                _.listRegisterFilter[i].moviment == Moviment.entry ? "Entrada" : "Saída",
                                style: TextStyle(
                                  fontSize: width * 0.03,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: width * 0.025),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Placa: ",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    _.listRegisterFilter[i].vehicle.model ?? "",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Placa: ",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    _.listRegisterFilter[i].vehicle.licensePlate?.toUpperCase() ?? "",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: _.listRegisterFilter[i].moviment == Moviment.entry ? true : false,
                                child: Row(
                                  children: [
                                    const Text(
                                      "Entrada: ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      _.listRegisterFilter[i].entryDateTime.toFormat_dd_MM_yyyy_hh_mm(),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: _.listRegisterFilter[i].moviment == Moviment.exit ? true : false,
                                child: Row(
                                  children: [
                                    const Text(
                                      "Saída: ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      _.listRegisterFilter[i].exitDateTime?.toFormat_dd_MM_yyyy_hh_mm() ?? "",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
