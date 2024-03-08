import 'dart:convert';

import 'package:coding_platform/data/user_data.dart';
import 'package:coding_platform/size_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../apis/api.dart';
import '../models/user.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<User> userData;

  Future<User> fetchUserData() async {
    final userData = Provider.of<UserData>(context, listen: false);
    String url = Api.BaseUrl + Api.userInfo;
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {

      User user =
          User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      userData.setUser(user);
      return user;
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    userData = fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userData,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          // print(snapshot.data.);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
            ),
            body: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 35 * SizeConfig.safeBlockHorizontal,
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(snapshot.data.avatar??'https://userpic.codeforces.org/no-avatar.jpg'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 6 * SizeConfig.safeBlockHorizontal,
                      ),
                      Text(
                        'Name-',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        width: 10 * SizeConfig.safeBlockHorizontal,
                      ),
                      Text(
                        '${snapshot.data.firstName} ${snapshot.data.lastName}'??'...',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockHorizontal,
                  ),

                  Row(
                    children: [
                      SizedBox(
                        width: 6 * SizeConfig.safeBlockHorizontal,
                      ),
                      Text(
                        'Org-',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 18 * SizeConfig.safeBlockHorizontal,
                      ),
                      Text(
                        snapshot.data.organization,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockHorizontal,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 6 * SizeConfig.safeBlockHorizontal,
                      ),
                      Text(
                        'Country-',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 10 * SizeConfig.safeBlockHorizontal,
                      ),
                      Text(
                          snapshot.data.country,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockHorizontal,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 6 * SizeConfig.safeBlockHorizontal,
                      ),
                      Text(
                        'Contri-',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 13 * SizeConfig.safeBlockHorizontal,
                      ),
                      Text(
                          '${snapshot.data.contribution}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockHorizontal,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 6 * SizeConfig.safeBlockHorizontal,
                      ),
                      Text(
                        'Rating-',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 12 * SizeConfig.safeBlockHorizontal,
                      ),
                      Text(
                          '${snapshot.data.rating}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockHorizontal,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 6 * SizeConfig.safeBlockHorizontal,
                      ),
                      Text(
                        'Max rating-',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 4 * SizeConfig.safeBlockHorizontal,
                      ),
                      Text(
                        '${snapshot.data.maxRating}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockHorizontal,
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
