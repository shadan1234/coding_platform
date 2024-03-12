import 'package:coding_platform/models/user_profile.dart';
import 'package:flutter/cupertino.dart';

import '../models/user.dart';

class UserData extends ChangeNotifier {
  static const String baseUrl = 'https://codeforces.com/';
  static const String userInfoEndpoint = 'api/user.info';
  static const String userStatusEndpoint = 'api/user.status';
  static const String contestListEndpoint = 'api/contest.list';

  String? _userHandle;
  User? _user;
  String? adminHandle;


  set user(User? user) {
    _user = user;
    notifyListeners();
  }

  User? get user => _user;

  String? get userHandle => _userHandle;

  set userHandle(String? handle) {
    _userHandle = handle;
    // print(_userHandle);
    notifyListeners();
  }

  String get userInfoUrl {
    // print('userinfo');
    // print(_userHandle);
    if (_userHandle == null) {
      throw Exception('User handle is not set');
    }
    return '$baseUrl$userInfoEndpoint?handles=$_userHandle&checkHistoricHandles=false';
  }

  String get userSubmissionsUrl {
    // print('usersumbis');
    if (_userHandle == null) {
      throw Exception('User handle is not set');
    }
    return '$baseUrl$userStatusEndpoint?handle=$_userHandle&from=1&count=20';
  }

  String get contestListUrl => '$baseUrl$contestListEndpoint';


}
