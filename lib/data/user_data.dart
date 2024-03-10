import 'package:coding_platform/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserData extends ChangeNotifier {
  static const String BaseUrl = 'https://codeforces.com/';
  static String userInfo =
      'api/user.info?handles=shadan122;&checkHistoricHandles=false';
  static String userSubmissions =
      'api/user.status?handle=shadan122&from=1&count=20';
  static const String contestList = 'api/contest.list';
  static const String contestPage = 'contest';

  String adminHandle = "";
  bool isAdmin = false;
  User? _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  User? get user => _user;

  void replace(String handle) {
    userInfo =
        userInfo.replaceFirst(RegExp('handles=[^;]*'), 'handles=$handle');
    userSubmissions =
        userSubmissions.replaceFirst(RegExp('handle=[^&]*'), 'handle=$handle');
    print(userSubmissions);
    notifyListeners();
  }
}
