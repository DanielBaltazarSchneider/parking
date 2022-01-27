import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:parking/app/data/enuns/moviment.dart';
import 'package:parking/app/data/enuns/vehicle_type.dart';
import 'package:parking/app/data/models/register.dart';
import 'package:parking/app/data/models/vehicle.dart';
import 'package:parking/app/data/packages/navigation/Nav.dart';
import 'package:parking/app/data/packages/uuid/uuid.dart';

class AddRegisterController extends GetxController {
  VehicleType vehicleTypeSelected = VehicleType.small;

  TextEditingController controllerLicencePlate = TextEditingController();
  TextEditingController controllerVehicleModel = TextEditingController();

  int indexParkingSpaceSelected = -1;

  void setVehicleType(VehicleType vehicleType) {
    vehicleTypeSelected = vehicleType;
    indexParkingSpaceSelected = -1;
    update();
  }

  void selectIndexParkingSpace(int index) {
    indexParkingSpaceSelected = index;
    update();
  }

  void createRegister(context) {
    Register register = Register(
      moviment: Moviment.entry,
      id: UuidGenerate.newUuid(),
      vehicle: Vehicle(
        vehicleType: vehicleTypeSelected,
        licensePlate: controllerLicencePlate.text,
        model: controllerVehicleModel.text,
      ),
      entryDateTime: DateTime.now(),
    );

    Map<String, dynamic> result = {
      "indexParkingSpace": indexParkingSpaceSelected,
      "register": register,
    };

    Nav.back(context: context, result: result);
  }
}
