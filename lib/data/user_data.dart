
import 'package:coding_platform/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class UserData extends ChangeNotifier{
  User? _user;
  void setUser(User user){
    _user=user;
    notifyListeners();
  }
 User? get user => _user;
}