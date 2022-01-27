import 'package:get/get.dart';
import 'package:parking/app/data/models/parking_space.dart';

class ListAllParkingSpacesViewController extends GetxController {
  ListAllParkingSpacesViewController(this.listParkingSpace);
  List<ParkingSpace> listParkingSpace = [];

  reorderList(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final ParkingSpace item = listParkingSpace.removeAt(oldIndex);
    listParkingSpace.insert(newIndex, item);
    update();
  }
}
