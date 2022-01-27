import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/app/data/enuns/vehicle_type.dart';
import 'package:parking/app/data/extensions/app_date_time.dart';
import 'package:parking/app/data/models/parking_space.dart';
import 'package:parking/app/data/packages/navigation/Nav.dart';
import 'package:parking/app/modules/parking/register_parking_space/add/add_register_controller.dart';
import 'package:parking/app/modules/parking/register_parking_space/widgets/select_parking_space.dart';
import 'package:parking/app/widgets/diviter_text.dart';
import 'package:parking/app/widgets/show_modal.dart';

class AddRegisterView extends StatelessWidget {
  const AddRegisterView({Key? key, required this.listParkingSpace}) : super(key: key);

  final List<ParkingSpace> listParkingSpace;

  String assetImageFromSizeVehicle(vehicleType) {
    return vehicleType == VehicleType.small
        ? "assets/images/car1_in.png"
        : vehicleType == VehicleType.medium
            ? "assets/images/car2_in.png"
            : "assets/images/car3_in.png";
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final AddRegisterController _controller = Get.put(AddRegisterController());

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
                GetBuilder<AddRegisterController>(builder: (_) {
                  return Positioned(
                    top: height * 0.025,
                    child: Container(
                      width: width,
                      height: (height * 0.4) - (height * 0.025),
                      child: Center(
                        child: Image.asset(
                          assetImageFromSizeVehicle(_.vehicleTypeSelected),
                          width: width * 0.55,
                        ),
                      ),
                    ),
                  );
                }),
                Positioned(
                  bottom: height * 0.015,
                  left: width * 0.03,
                  child: Column(
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
                        DateTime.now().toFormat_hh_mm(),
                        style: TextStyle(
                          fontSize: width * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DividerText(
                    textTitle: "Dados do veículos: ",
                  ),
                  GetBuilder<AddRegisterController>(
                    builder: (_) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                activeColor: Colors.amber,
                                value: _.vehicleTypeSelected == VehicleType.small,
                                onChanged: (stat) => _.setVehicleType(VehicleType.small),
                              ),
                              Text("Pequeno"),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                activeColor: Colors.amber,
                                value: _.vehicleTypeSelected == VehicleType.medium,
                                onChanged: (stat) => _.setVehicleType(VehicleType.medium),
                              ),
                              Text("Médio"),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                activeColor: Colors.amber,
                                value: _.vehicleTypeSelected == VehicleType.large,
                                onChanged: (stat) => _.setVehicleType(VehicleType.large),
                              ),
                              Text("Grande"),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: width * 0.025, bottom: width * 0.025),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Modelo"),
                        SizedBox(width: width * 0.05),
                        Container(
                          width: width * 0.45,
                          child: TextField(
                            controller: _controller.controllerVehicleModel,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(0),
                            ),
                          ),
                        ),
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
                        Container(
                          width: width * 0.45,
                          child: TextField(
                            controller: _controller.controllerLicencePlate,
                            textCapitalization: TextCapitalization.characters,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  DividerText(
                    textTitle: "Local da vaga",
                  ),
                  GetBuilder<AddRegisterController>(builder: (_) {
                    return Visibility(
                      visible: _.indexParkingSpaceSelected != -1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Vaga selecionada:  "),
                          Text(
                            (_.indexParkingSpaceSelected + 1).toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.045,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: width * 0.4,
                        child: ElevatedButton(
                          onPressed: () async {
                            await ShowModal.show(
                              context,
                              clild: SelectParkingSpace(
                                listParkingSpace: listParkingSpace,
                                vehicleType: _controller.vehicleTypeSelected,
                                onTapSpace: (space) {
                                  _controller.selectIndexParkingSpace(space);
                                },
                              ),
                            );
                          },
                          child: const Text("Escolher"),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Center(
                    child: SizedBox(
                      width: width * 0.65,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.save),
                        onPressed: () => _controller.createRegister(context),
                        label: const Text("Registrar entrada"),
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
