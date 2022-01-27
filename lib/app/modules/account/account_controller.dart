import 'package:get/get.dart';
import 'package:parking/app/app_controller.dart';
import 'package:parking/app/data/models/account.dart';
import 'package:parking/app/data/packages/navigation/Nav.dart';
import 'package:parking/app/data/repositories/account_repository.dart';
import 'package:parking/app/modules/parking/home_parking/home_parking_view.dart';

class AccountController extends GetxController {
  static AccountController get to => Get.find();
  Account account = AppController.to.account;

  Future<void> navigateToParkingView(context, index) async {
    await Nav.to(HomeParkingView(parking: account.listParking[index]), context);
    update();
  }

  void createParking(String name) {
    bool create = account.addParking(name: name);
    if (create) {
      saveAccount();
    }
    update();
  }

  Future<void> saveAccount() async {
    await AccountRepository.writeData(account);
  }

  void deleteParking(int index) {
    account.removeParking(index: index);
    update();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    account = await AccountRepository.readData();
    update();
  }
}
