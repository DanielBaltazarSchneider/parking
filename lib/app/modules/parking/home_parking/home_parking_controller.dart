import 'package:get/get.dart';
import 'package:parking/app/data/models/parking.dart';
import 'package:parking/app/data/models/parking_space.dart';
import 'package:parking/app/data/models/register.dart';
import 'package:parking/app/data/packages/navigation/Nav.dart';
import 'package:parking/app/modules/account/account_controller.dart';
import 'package:parking/app/modules/parking/add_parking_space/add_parking_space_view.dart';
import 'package:parking/app/modules/parking/list_parking_spaces/list_parking_spaces.dart';
import 'package:parking/app/modules/parking/register_parking_space/add/add_register_view.dart';
import 'package:parking/app/modules/parking/register_parking_space/remove/remove_register_view.dart';

class HomeParkingController extends GetxController {
  HomeParkingController(this.parking);

  Parking parking;

  Future<void> navigateToNewParkingSpace(context) async {
    var data = await Nav.to(const AddParkingSpaceView(), context);
    if (data != null) {
      saveNewParkinSpace(data);
    }
  }

  saveNewParkinSpace(List<ParkingSpace> list) async {
    parking.listParkingSpace += list;
    await AccountController.to.saveAccount();
    update(["count", "home"]);
  }

  newRegisterParkingSpace(context) async {
    var data = await Nav.to(AddRegisterView(listParkingSpace: parking.listParkingSpace), context);
    if (data != null) {
      if (data["indexParkingSpace"] != -1) {
        addRegisterToParkingSpace(data["indexParkingSpace"], data["register"]);
        addRegisterHistoric(data["register"]);
      }
    }
    await AccountController.to.saveAccount();
    update(["count", "list"]);
  }

  addRegisterToParkingSpace(int index, Register? register) async {
    parking.listParkingSpace[index].register = register;
    await AccountController.to.saveAccount();
    update(["count", "list"]);
  }

  removeRegisterParkingSpace(int index) async {
    parking.listParkingSpace[index].register = null;
    await AccountController.to.saveAccount();
    update(["count", "list"]);
  }

  addRegisterHistoric(Register register) async {
    parking.historic.listRegisters.add(register);
    await AccountController.to.saveAccount();
    update(["count", "list"]);
  }

  exitRegisterParkingSpace(context) async {
    var registerData = await Nav.to(
      ListParkingSpaces(listParkingSpace: parking.listParkingSpace),
      context,
    );
    if (registerData != null) {
      var data = await Nav.to(
          RemoveRegisterView(
            indexParkingSpace: registerData["indexParkingSpace"],
            register: registerData["register"],
          ),
          context);
      if (data != null) {
        if (data["indexParkingSpace"] != -1) {
          Register exitRegister = data["register"];
          addRegisterHistoric(exitRegister);
          removeRegisterParkingSpace(data["indexParkingSpace"]);
        }
      }
    }
    await AccountController.to.saveAccount();
  }

  void updateList() async {
    parking = parking;
    update(["drawer"]);
    await AccountController.to.saveAccount();
  }
}
