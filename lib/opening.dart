import 'package:coding_platform/data/user_data.dart';
import 'package:coding_platform/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/me.dart';

class OpeningPage extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: controller,
                decoration: InputDecoration(
                    hintText: 'Your cf handle',
                    contentPadding: EdgeInsets.all(12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    userData.adminHandle=(controller.text);
                    // userData.isAdmin=true;
                    userData.replace(controller.text);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
