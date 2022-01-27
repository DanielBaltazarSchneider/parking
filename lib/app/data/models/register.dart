import 'package:parking/app/data/enuns/moviment.dart';
import 'package:parking/app/data/enuns/vehicle_type.dart';
import 'package:parking/app/data/models/vehicle.dart';

class Register {
  String id;
  DateTime entryDateTime;
  DateTime? exitDateTime;
  Vehicle vehicle;
  Moviment moviment;

  Register({
    required this.id,
    required this.entryDateTime,
    this.exitDateTime,
    required this.vehicle,
    required this.moviment,
  });

  factory Register.fromMap(Map<String, dynamic> json) => Register(
        id: json["id"] == null ? null : json["id"],
        entryDateTime: json["entryDateTime"] == null ? DateTime.now() : DateTime.parse(json["entryDateTime"]),
        exitDateTime: json["exitDateTime"] == null ? null : DateTime.parse(json["exitDateTime"]),
        vehicle: json["vehicle"] == null ? Vehicle(vehicleType: VehicleType.small) : Vehicle.fromMap(json["vehicle"]),
        moviment: json["moviment"] == "entry" ? Moviment.entry : Moviment.exit,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "entryDateTime": entryDateTime.toIso8601String(),
        "exitDateTime": exitDateTime == null ? null : exitDateTime!.toIso8601String(),
        "vehicle": vehicle == null ? null : vehicle.toMap(),
        "moviment": moviment == Moviment.entry ? "entry" : "exit",
      };
}
