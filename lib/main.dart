import 'dart:convert';
import 'package:coding_platform/data/user_data.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';

void main() {
 runApp(MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
        debugShowCheckedModeBanner:false ,
        home: MultiProvider(

            providers: [
              ChangeNotifierProvider(create: (context) => UserData(),),
            ],
            child: Home())
    );

  }
}

