import 'package:flutter_test/flutter_test.dart';
import 'package:parking/app/data/enuns/moviment.dart';
import 'package:parking/app/data/enuns/vehicle_type.dart';
import 'package:parking/app/data/models/account.dart';
import 'package:parking/app/data/models/historic.dart';
import 'package:parking/app/data/models/register.dart';
import 'package:parking/app/data/models/vehicle.dart';

void main() async {
  Account account = Account(listParking: []);
  Historic historic = Historic(listRegisters: []);

  bool createdParking = account.addParking(name: "Estacionamento do João");
  bool createdParkingSpace = account.listParking[0].addParkingSpace(VehicleType.small);
  bool deleteParkingSpace = account.listParking[0].removeParkingSpace(0);

  Map<VehicleType, int> mapParkingSpace = {
    VehicleType.small: 15,
    VehicleType.medium: 5,
    VehicleType.large: 4,
  };

  bool createMultiplesParkingSpace = account.listParking[0].addMultipleParkingSpace(mapParkingSpace);

  int totalVehicles = account.listParking[0].length;

  int totalVehiclesSmall = account.listParking[0].smallLength;
  int totalVehiclesMedium = account.listParking[0].mediumLength;
  int totalVehiclesLarge = account.listParking[0].largeLength;

  int totalVehiclesSmallAvailable = account.listParking[0].smallAvailableLength;
  int totalVehiclesMediumAvailable = account.listParking[0].mediumAvailableLength;
  int totalVehiclesLargeAvailable = account.listParking[0].largeAvailableLength;

  group("Criar estacionamento", () {
    test("Deve criar um novo estacionamento", () {
      expect(true, createdParking);
    });
  });

  group("Criar, remover e contar vagas", () {
    test("Deve criar uma nova vaga para veículo pequeno no estacionamento", () {
      expect(true, createdParkingSpace);
    });

    test("Deve remover uma vaga de estacionamento", () {
      expect(true, deleteParkingSpace);
    });

    test("Deve criar multiplas vagas de estacionamento", () {
      expect(true, createMultiplesParkingSpace);
    });

    test("Deve ter criado 24 vagas veiculos", () {
      expect(24, totalVehicles);
    });

    test("Deve ter criado 15 vagas veiculos pequenos", () {
      expect(15, totalVehiclesSmall);
    });

    test("Deve ter criado 5 vagas veiculos médios", () {
      expect(5, totalVehiclesMedium);
    });

    test("Deve ter criado 4 vagas veiculos grandes", () {
      expect(4, totalVehiclesLarge);
    });

    test("Deve possuir 15 vagas veiculos pequenos disponíveis", () {
      expect(15, totalVehiclesSmallAvailable);
    });

    test("Deve possuir 5 vagas veiculos médios disponíveis", () {
      expect(5, totalVehiclesMediumAvailable);
    });

    test("Deve possuir 4 vagas veiculos grandes disponíveis", () {
      expect(4, totalVehiclesLargeAvailable);
    });
  });

  group("Entrada, saída e transferir veiculo de vaga", () {
    group("Inserir veículos e conferir vagas", () {
      Register register1 = Register(
        moviment: Moviment.entry,
        id: "1",
        vehicle: Vehicle(vehicleType: VehicleType.small),
        entryDateTime: DateTime.now(),
      );

      Register register2 = Register(
        moviment: Moviment.entry,
        id: "2",
        vehicle: Vehicle(vehicleType: VehicleType.small),
        entryDateTime: DateTime.now(),
      );

      Register register3 = Register(
        moviment: Moviment.entry,
        id: "3",
        vehicle: Vehicle(vehicleType: VehicleType.medium),
        entryDateTime: DateTime.now(),
      );

      Register register4 = Register(
        moviment: Moviment.entry,
        id: "4",
        vehicle: Vehicle(vehicleType: VehicleType.large),
        entryDateTime: DateTime.now(),
      );

      bool addVehicle1 = account.listParking[0].registerEntry(register: register1);
      bool addVehicle2 = account.listParking[0].registerEntry(register: register2);
      bool addVehicle3 = account.listParking[0].registerEntry(register: register3);
      bool addVehicle4 = account.listParking[0].registerEntry(register: register4);

      int totalSmallAvailableAfterAdding = account.listParking[0].smallAvailableLength;
      int totalMediumAvailableAfterAdding = account.listParking[0].mediumAvailableLength;
      int totalLargeAvailableAfterAdding = account.listParking[0].largeAvailableLength;
      test("Deve inserir os veículos nas vagas", () {
        expect(true, addVehicle1 && addVehicle2 && addVehicle3 && addVehicle4);
      });
      test("Deve possuir 13 vagas veiculos pequenos disponíveis", () {
        expect(13, totalSmallAvailableAfterAdding);
      });
      test("Deve possuir 4 vagas veiculos médios disponíveis", () {
        expect(4, totalMediumAvailableAfterAdding);
      });
      test("Deve possuir 3 vagas veiculos grandes disponíveis", () {
        expect(3, totalLargeAvailableAfterAdding);
      });
    });

    group("Saída de veículos e conferir vagas", () {
      Register exitRegister1 = account.listParking[0].returnRegisterById(1);

      bool registerExit1 = account.listParking[0].registerExit(exitRegister1.id);
      bool addedRegister1 = historic.addRegister(exitRegister1);

      int totalSmallAvailableAfterAdding = account.listParking[0].smallAvailableLength;
      int totalMediumAvailableAfterAdding = account.listParking[0].mediumAvailableLength;
      int totalLargeAvailableAfterAdding = account.listParking[0].largeAvailableLength;
      test("Deve retirar o veículo da vaga", () {
        expect(true, registerExit1);
      });
      test("Deve possuir 14 vagas veiculos pequenos disponíveis", () {
        expect(14, totalSmallAvailableAfterAdding);
      });
      test("Deve possuir 4 vagas veiculos médios disponíveis", () {
        expect(4, totalMediumAvailableAfterAdding);
      });
      test("Deve possuir 3 vagas veiculos grandes disponíveis", () {
        expect(3, totalLargeAvailableAfterAdding);
      });

      test("Deve adicionar o registro ao historico", () {
        expect(true, addedRegister1);
      });

      test("Deve possuir 1 registro no histórico", () {
        expect(1, historic.length);
      });
    });
  });
}
