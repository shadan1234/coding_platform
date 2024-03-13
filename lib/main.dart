import 'package:coding_platform/data/friends_data.dart';
import 'package:coding_platform/data/user_data.dart';
import 'package:coding_platform/opening.dart';
import 'package:coding_platform/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'database/database_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final databaseHelper = DatabaseHelper();
  final database= await databaseHelper.database;
  final adminExist = await databaseHelper.isAdminExist();

  runApp( MyApp(
      adminExist: adminExist
  ));
}

class MyApp extends StatelessWidget {
  final bool adminExist;

  MyApp({required this.adminExist});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserData(),
        ),
        ChangeNotifierProvider(create: (context)=>FriendsData())
      ],
      child: MaterialApp(
          theme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home:
          adminExist ? HomePage() :
          OpeningPage()),
    );
  }
}
