import 'package:coding_platform/data/friends_data.dart';
import 'package:coding_platform/data/user_data.dart';
import 'package:coding_platform/opening.dart';
import 'package:coding_platform/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
          home: OpeningPage()),
    );
  }
}
