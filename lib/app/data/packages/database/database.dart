import 'package:shared_preferences/shared_preferences.dart';

class DataBase {
  static Future<String?> readData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("account");
  }

  static Future<bool> writeData(String json) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString("account", json);
  }
}
