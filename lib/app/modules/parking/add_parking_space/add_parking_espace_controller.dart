import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:parking/app/data/enuns/vehicle_type.dart';
import 'package:parking/app/data/models/parking_space.dart';
import 'package:parking/app/data/packages/navigation/Nav.dart';

class AddParkingSpaceController extends GetxController {
  int smallSpace = 0;
  int mediumSpace = 0;
  int largeSpace = 0;

  TextEditingController multiSmallSpaceController = TextEditingController();
  TextEditingController multiMediumSpaceController = TextEditingController();
  TextEditingController multiLargeSpaceController = TextEditingController();

  List<ParkingSpace> listParkingSpace = [];

  void addSmallSpace() {
    smallSpace++;
    update(["smallSpace"]);
  }

  void addMediumSpace() {
    mediumSpace++;
    update(["mediumSpace"]);
  }

  void addLargeSpace() {
    largeSpace++;
    update(["largeSpace"]);
  }

  void removeSmallSpace() {
    smallSpace > 0 ? smallSpace-- : null;
    update(["smallSpace"]);
  }

  void removeMediumSpace() {
    mediumSpace > 0 ? mediumSpace-- : null;
    update(["mediumSpace"]);
  }

  void removeLargeSpace() {
    largeSpace > 0 ? largeSpace-- : null;
    update(["largeSpace"]);
  }

  generateAndBack(context) {
    generateParkingSpaces();
    Nav.back(context: context, result: listParkingSpace);
  }

  generateParkingSpaces() {
    listParkingSpace = [];
    generateSmallSpaces();
    generateMediumSpaces();
    generateLargeSpaces();
  }

  generateSmallSpaces() {
    for (int i = 0; i < smallSpace; i++) {
      listParkingSpace.add(
        ParkingSpace(vehicleType: VehicleType.small),
      );
    }
  }

  generateMediumSpaces() {
    for (int i = 0; i < mediumSpace; i++) {
      listParkingSpace.add(
        ParkingSpace(vehicleType: VehicleType.medium),
      );
    }
  }

  generateLargeSpaces() {
    for (int i = 0; i < largeSpace; i++) {
      listParkingSpace.add(
        ParkingSpace(vehicleType: VehicleType.large),
      );
    }
  }
}
