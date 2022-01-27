import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/app/data/enuns/vehicle_type.dart';
import 'package:parking/app/data/extensions/app_date_time.dart';
import 'package:parking/app/data/models/register.dart';
import 'package:parking/app/data/packages/navigation/Nav.dart';
import 'package:parking/app/modules/parking/register_parking_space/remove/remove_register_controller.dart';
import 'package:parking/app/widgets/diviter_text.dart';

class RemoveRegisterView extends StatelessWidget {
  const RemoveRegisterView({Key? key, required this.indexParkingSpace, required this.register}) : super(key: key);

  final int indexParkingSpace;
  final Register register;

  String assetImageFromSizeVehicle(vehicleType) {
    return vehicleType == VehicleType.small
        ? "assets/images/car1_exit.png"
        : vehicleType == VehicleType.medium
            ? "assets/images/car2_exit.png"
            : "assets/images/car3_exit.png";
  }

  String convertHoursMinutes(Duration time) {
    return "${time.inHours}h${time.inMinutes % 60}min";
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final RemoveRegisterController _controller = Get.put(RemoveRegisterController());

    return Scaffold(
      appBar: AppBar(
          title: Text("Registro de veículo"),
          leading: InkWell(
            onTap: () => Nav.back(context: context),
            child: const Icon(Icons.keyboard_arrow_left_sharp),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: width,
                  height: height * 0.35,
                  color: Colors.grey,
                ),
                Positioned(
                  top: height * 0.01,
                  child: SizedBox(
                    width: width,
                    child: Center(
                      child: Icon(
                        Icons.location_on,
                        size: width * 0.3,
                        color: Colors.grey.shade800.withOpacity(0.15),
                      ),
                    ),
                  ),
                ),
                GetBuilder<RemoveRegisterController>(builder: (_) {
                  return Positioned(
                    top: height * 0.025,
                    child: Container(
                      width: width,
                      height: (height * 0.4) - (height * 0.025),
                      child: Center(
                        child: Image.asset(
                          assetImageFromSizeVehicle(register.vehicle.vehicleType),
                          width: width * 0.55,
                        ),
                      ),
                    ),
                  );
                }),
                Positioned(
                  bottom: height * 0.015,
                  child: Container(
                    padding: EdgeInsets.only(left: width * 0.025, right: width * 0.025),
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Entrada",
                              style: TextStyle(
                                fontSize: width * 0.06,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              register.entryDateTime.toFormat_hh_mm(),
                              style: TextStyle(
                                fontSize: width * 0.03,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                fontSize: width * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              convertHoursMinutes(DateTime.now().difference(register.entryDateTime)),
                              style: TextStyle(
                                fontSize: width * 0.03,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Saída",
                              style: TextStyle(
                                fontSize: width * 0.06,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              DateTime.now().toFormat_hh_mm(),
                              style: TextStyle(
                                fontSize: width * 0.03,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DividerText(
                    textTitle: "Dados do veículos: ",
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: width * 0.025, bottom: width * 0.025),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Modelo"),
                        SizedBox(width: width * 0.05),
                        Text(register.vehicle.model ?? ""),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: width * 0.025, bottom: width * 0.025),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Placa"),
                        SizedBox(width: width * 0.05),
                        Text(register.vehicle.licensePlate ?? ""),
                      ],
                    ),
                  ),
                  const DividerText(
                    textTitle: "Local da vaga",
                  ),
                  GetBuilder<RemoveRegisterController>(builder: (_) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Vaga selecionada:  "),
                        Text(
                          (indexParkingSpace + 1).toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.045,
                          ),
                        ),
                      ],
                    );
                  }),
                  Divider(),
                  Center(
                    child: SizedBox(
                      width: width * 0.65,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.save),
                        onPressed: () => _controller.exitRegister(context: context, register: register, index: indexParkingSpace),
                        label: const Text("Registrar saída"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                      ),
                    ),
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
