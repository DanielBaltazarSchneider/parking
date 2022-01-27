import 'package:parking/app/data/enuns/vehicle_type.dart';
import 'package:parking/app/data/models/historic.dart';
import 'package:parking/app/data/models/parking_space.dart';
import 'package:parking/app/data/models/register.dart';

class Parking {
  Parking({
    required this.uuid,
    required this.name,
    required this.listParkingSpace,
    required this.historic,
  });

  String uuid;
  String name;
  List<ParkingSpace> listParkingSpace;
  Historic historic;

  factory Parking.fromMap(Map<String, dynamic> json) => Parking(
        uuid: json["uuid"] ?? null,
        name: json["name"] ?? null,
        listParkingSpace:
            json["listParkingSpace"] == null ? [] : List<ParkingSpace>.from(json["listParkingSpace"].map((x) => ParkingSpace.fromMap(x))),
        historic: json["historic"] == null ? Historic(listRegisters: []) : Historic.fromMap(json["historic"]),
      );

  Map<String, dynamic> toMap() => {
        "uuid": uuid == null ? null : uuid,
        "name": name == null ? null : name,
        "listParkingSpace": listParkingSpace == null ? null : List<dynamic>.from(listParkingSpace.map((x) => x.toMap())),
        "historic": historic == null ? null : historic.toMap(),
      };

  int get length => listParkingSpace.length;

  int get smallLength => listParkingSpace.where((element) => element.vehicleType == VehicleType.small).toList().length;

  int get mediumLength => listParkingSpace.where((element) => element.vehicleType == VehicleType.medium).toList().length;

  int get largeLength => listParkingSpace.where((element) => element.vehicleType == VehicleType.large).toList().length;

  int get smallAvailableLength =>
      listParkingSpace.where((element) => element.vehicleType == VehicleType.small && element.register == null).toList().length;

  int get mediumAvailableLength =>
      listParkingSpace.where((element) => element.vehicleType == VehicleType.medium && element.register == null).toList().length;

  int get largeAvailableLength =>
      listParkingSpace.where((element) => element.vehicleType == VehicleType.large && element.register == null).toList().length;

  bool addParkingSpace(VehicleType vehicleType) {
    try {
      listParkingSpace.add(ParkingSpace(vehicleType: vehicleType));
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  bool removeParkingSpace(int index) {
    try {
      listParkingSpace.removeAt(index);
      return true;
    } catch (error) {
      return false;
    }
  }

  bool addMultipleParkingSpace(Map<VehicleType, int> mapParkingSpaces) {
    try {
      for (VehicleType vehicleType in mapParkingSpaces.keys) {
        for (int i = 0; i < mapParkingSpaces[vehicleType]!; i++) {
          if (!addParkingSpace(vehicleType)) return false;
        }
      }
      return true;
    } catch (err) {
      return false;
    }
  }

  bool registerEntry({required Register register}) {
    try {
      if (_isVacancy(register.vehicle.vehicleType)) {
        _addRegisterInParkingSpaceVacancy(register);
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  bool registerExit(String idRegister) {
    try {
      List<ParkingSpace> listSpaces = listParkingSpace.where((element) => element.register != null).toList();
      int indexList = listSpaces.indexWhere((element) => element.register!.id == idRegister);
      listParkingSpace[indexList].register = null;
      return true;
    } catch (error) {
      return false;
    }
  }

  Register returnRegisterById(int idRegister) {
    List<ParkingSpace> listSpaces = listParkingSpace.where((element) => element.register != null).toList();
    int indexList = listSpaces.indexWhere((element) => element.register!.id == idRegister);
    return listParkingSpace[indexList].register!;
  }

  bool _isVacancy(VehicleType vehicleType) {
    try {
      int spaces = listParkingSpace.where((element) => element.vehicleType == vehicleType && element.register == null).toList().length;
      if (spaces > 0) {
        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  }

  List<int> _listParkingSpacesAvailable(VehicleType vehicleType) {
    List<int> indexAvailable = [];
    for (int i = 0; i < listParkingSpace.length; i++) {
      if (listParkingSpace[i].vehicleType == vehicleType && listParkingSpace[i].register == null) {
        indexAvailable.add(i);
      }
    }
    return indexAvailable;
  }

  bool _addRegisterInParkingSpaceVacancy(Register register) {
    try {
      listParkingSpace[_listParkingSpacesAvailable(register.vehicle.vehicleType)[0]].register = register;
      return true;
    } catch (error) {
      return false;
    }
  }
}
