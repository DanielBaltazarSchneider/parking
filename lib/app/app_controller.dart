import 'package:get/get.dart';
import 'package:parking/app/data/models/account.dart';

class AppController extends GetxController {
  static AppController get to => Get.find();

  Account account = Account(listParking: []);
}
