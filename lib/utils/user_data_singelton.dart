import 'package:coding_platform/data/user_data.dart';

class UserDataSingleton {
  static final UserDataSingleton _singleton = UserDataSingleton._internal();

  factory UserDataSingleton() {
    return _singleton;
  }

  UserDataSingleton._internal();

  UserData userData = UserData();
}
