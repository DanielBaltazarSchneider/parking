import 'package:parking/app/data/models/register.dart';

class Historic {
  List<Register> listRegisters = [];

  Historic({
    required this.listRegisters,
  });

  factory Historic.fromMap(Map<String, dynamic> json) => Historic(
        listRegisters: json["listRegisters"] == null ? [] : List<Register>.from(json["listRegisters"].map((x) => Register.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "listRegisters": listRegisters == null ? null : List<dynamic>.from(listRegisters.map((x) => x.toMap())),
      };

  bool addRegister(Register register) {
    try {
      register.exitDateTime = register.exitDateTime ?? DateTime.now();
      listRegisters.add(register);
      return true;
    } catch (error) {
      return false;
    }
  }

  int get length => listRegisters.length;
}
