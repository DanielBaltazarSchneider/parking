import 'dart:convert';

import 'package:parking/app/data/models/account.dart';
import 'package:parking/app/data/packages/database/database.dart';

class AccountRepository {
  static writeData(Account account) async {
    String data = jsonEncode(account.toMap());
    bool save = await DataBase.writeData(data);
    print(save);
  }

  static Future<Account> readData() async {
    String? data = await DataBase.readData();
    if (data != null) {
      Account account = Account.fromMap(jsonDecode(data));
      return account;
    }
    return Account(listParking: []);
  }
}
