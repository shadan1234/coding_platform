import 'package:flutter/cupertino.dart';

class FriendsData extends ChangeNotifier{
  List<String> friends=[];
  void add(String handle){
    friends.add(handle);
    notifyListeners();
  }
}