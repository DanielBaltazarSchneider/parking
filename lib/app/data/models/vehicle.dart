import 'package:parking/app/data/enuns/vehicle_type.dart';

class Vehicle {
  Vehicle({
    this.vehicleType = VehicleType.small,
    this.licensePlate = "",
    this.model = "",
  });

  VehicleType vehicleType;
  String? licensePlate;
  String? model;

  factory Vehicle.fromMap(Map<String, dynamic> json) => Vehicle(
        vehicleType: json["vehicleType"] != null
            ? (json["vehicleType"] == "small"
                ? VehicleType.small
                : json["vehicleType"] == "medium"
                    ? VehicleType.medium
                    : VehicleType.large)
            : VehicleType.large,
        licensePlate: json["licensePlate"],
        model: json["model"],
      );

  Map<String, dynamic> toMap() => {
        "vehicleType": vehicleType == VehicleType.small
            ? "small"
            : vehicleType == VehicleType.medium
                ? "medium"
                : "large",
        "licensePlate": licensePlate,
        "model": model,
      };
}
