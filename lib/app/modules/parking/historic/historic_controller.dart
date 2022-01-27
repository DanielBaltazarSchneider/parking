import 'package:get/get.dart';
import 'package:parking/app/data/models/historic.dart';
import 'package:parking/app/data/models/register.dart';

class HistoricController extends GetxController {
  HistoricController(this.historic) {
    returnDatesParking();
  }

  Historic historic;

  List<DateTime> listDates = [];
  DateTime? selectedDate;

  List<Register> listRegisterFilter = [];

  void filterRegister() {
    listRegisterFilter = historic.listRegisters.where((element) => isEqualsDate(element.entryDateTime, selectedDate!)).toList();
  }

  bool isEqualsDate(DateTime _date1, DateTime _date2) {
    return _date1.year == _date2.year && _date1.month == _date2.month && _date1.day == _date2.day;
  }

  void selectDateTime(DateTime date) {
    selectedDate = date;
    filterRegister();
    update();
  }

  void returnDatesParking() {
    List<DateTime> _dates = [];
    for (Register register in historic.listRegisters) {
      _dates.add(register.entryDateTime);
    }
    listDates = _dates.toSet().toList();
  }
}
