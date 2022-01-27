import 'package:parking/app/data/models/historic.dart';
import 'package:parking/app/data/models/parking.dart';
import 'package:parking/app/data/packages/uuid/uuid.dart';

class Account {
  Account({
    required this.listParking,
  });

  List<Parking> listParking;

  factory Account.fromMap(Map<String, dynamic> json) => Account(
        listParking: json["listParking"] == null ? [] : List<Parking>.from(json["listParking"].map((x) => Parking.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "listParking": List<dynamic>.from(listParking.map((x) => x.toMap())),
      };

  bool addParking({required String name}) {
    try {
      listParking.add(Parking(
          listParkingSpace: [],
          name: name,
          uuid: UuidGenerate.newUuid(),
          historic: Historic(
            listRegisters: [],
          )));
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  bool removeParking({required int index}) {
    try {
      listParking.removeAt(index);
      return true;
    } catch (error) {
      return false;
    }
  }
}
