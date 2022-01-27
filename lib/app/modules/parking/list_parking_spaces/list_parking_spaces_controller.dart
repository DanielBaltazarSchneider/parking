import 'package:get/get.dart';
import 'package:parking/app/data/models/register.dart';
import 'package:parking/app/data/packages/navigation/Nav.dart';

class ListParkingSpacesController extends GetxController {
  selectParkingSpace(context, {required int index, required Register register}) {
    Map<String, dynamic> result = {
      "indexParkingSpace": index,
      "register": register,
    };

    Nav.back(context: context, result: result);
  }
}
