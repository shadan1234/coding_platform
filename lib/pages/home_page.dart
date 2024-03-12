import 'package:coding_platform/data/user_data.dart';
import 'package:coding_platform/pages/chatbot.dart';
import 'package:coding_platform/pages/friends.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'me.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> children = [Me(), Friends(), ChatBot()];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          return setState(() {
            final _userData=Provider.of<UserData>(context,listen: false);
            _userData.userHandle=(_userData.adminHandle);
            selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(

              icon: Icon(Icons.self_improvement), label: 'Me'),
          BottomNavigationBarItem(
              icon: Icon(Icons.child_friendly_sharp), label: 'Friends'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Gemma'),
        ],

        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber,
        selectedFontSize: 16,
        // showUnselectedLabels: false,
        unselectedFontSize: 12,
        unselectedIconTheme: IconThemeData(size: 22),

        iconSize: 24,
      ),
      body: children[selectedIndex],
    );
  }
}
