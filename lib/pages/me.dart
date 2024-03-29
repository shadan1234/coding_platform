import 'package:coding_platform/data/user_data.dart';
import 'package:coding_platform/pages/profile/profile.dart';
import 'package:coding_platform/service/user_service.dart';
import 'package:coding_platform/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../database/database_helper.dart';
import '../models/user.dart';

class Me extends StatefulWidget {
  @override
  State<Me> createState() => _MeState();
}

class _MeState extends State<Me> {
  late Future<User> _user;

  @override
  void initState() {
    super.initState();
    _user = _fetchUserData();
  }

  Future<User> _fetchUserData() async {
    final userData = Provider.of<UserData>(context, listen: false);
    final databaseHelper = DatabaseHelper();
    String? adminHandle=userData.adminHandle;
    if(adminHandle==null){
      final adminUser=await databaseHelper.getAdminUser();
      userData.adminHandle=adminUser.handle;
      userData.userHandle=adminUser?.handle;
    }
    final storedUser =
        await databaseHelper.getUserByHandle(userData.userHandle!);

    if (storedUser != null) {
      // User data found in local database, return it
      userData.user=storedUser;
      return storedUser;
    } else {
      // Fetch user data from API
      final apiUserData = await UserService()
          .fetchUserDataFromAPI(userData.userHandle!, context);
      // Store fetched user data in local database
      if(userData.userHandle==userData.adminHandle){
      apiUserData.isAdmin=1;}else{
        apiUserData.isAdmin=0;
      }
      userData.user=apiUserData;
      await databaseHelper.insertUser(apiUserData);
      // Return fetched user data
      return apiUserData;
    }
  }

  bool _isLoading = false;

  void _refreshUserData() async {
    setState(() {
      _isLoading = true; // Set loading flag to true when refresh is initiated
    });

    try {
      final userData = Provider.of<UserData>(context, listen: false);
      final databaseHelper = DatabaseHelper();

      final _user = await UserService().fetchUserDataFromAPI(userData.userHandle!, context);
      if (userData.userHandle == userData.adminHandle) {
        _user.isAdmin = 1;
      } else {
        _user.isAdmin = 0;
      }

      await databaseHelper.updateUser(_user);
      setState(() {
        _isLoading = false; // Set loading flag to false after data is fetched
      });
    } catch (error) {
      setState(() {
        _isLoading = false; // Set loading flag to false if an error occurs during fetching
      });
      // Handle error here (e.g., display a Snackbar)
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return FutureBuilder(
        future: _user,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting || _isLoading) {
            return Center(child: CircularProgressIndicator());
          }
         else if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text('Codeforces'),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Profile()));
                        },
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage('${snapshot.data.avatar}'),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: _refreshUserData, icon: Icon(Icons.refresh))
                  ],
                ),
                body: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data.rank ?? '...',
                            style: TextStyle(color: Colors.grey, fontSize: 20),
                          ),
                          Text(
                            snapshot.data.handle ?? '...',
                            style: TextStyle(color: Colors.grey, fontSize: 22),
                          ),
                          SizedBox(
                            height: 4 * SizeConfig.safeBlockHorizontal,
                          ),
                          Text(
                              'Rating: ${snapshot.data.rating ?? '...'}, (max ${snapshot.data.maxRank ?? '...'}, ${snapshot.data.maxRating ?? '...'})'),
                          SizedBox(
                            height: SizeConfig.safeBlockHorizontal,
                          ),
                          Text(
                              'Contribution: ${snapshot.data.contribution ?? '...'}'),
                          SizedBox(
                            height: 3 * SizeConfig.safeBlockHorizontal,
                          ),
                          Container(
                              height: 240,
                              child: Column(children: [
                                Text(
                                  'Recent Submissions',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 2 * SizeConfig.safeBlockHorizontal,
                                ),
                                SizedBox(
                                  height: 200,
                                  child:
                                      // print(user);
                                      ListView.builder(
                                          itemCount: snapshot
                                              .data.recentSubmission.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                                onTap: () {
                                                  launchUrl(Uri.parse(snapshot
                                                          .data
                                                          .recentSubmission[
                                                      index]));
                                                },
                                                child: ListTile(
                                                  leading:
                                                      Text('${index + 1}.)'),
                                                  title: Text(
                                                    snapshot.data
                                                            .recentSubmission[
                                                        index],
                                                    style: TextStyle(
                                                        color:
                                                            Colors.blueAccent,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        decorationColor:
                                                            Colors.blueAccent),
                                                  ),
                                                ));
                                          }),
                                ),
                              ])),
                          Container(
                              height: 240,
                              child: Column(children: [
                                Text(
                                  'Upcoming Contests',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 2 * SizeConfig.safeBlockHorizontal,
                                ),
                                SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                        itemCount: snapshot
                                            .data.upcomingContest.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              launchUrl(Uri.parse(
                                                  'https://codeforces.com/contests'));
                                            },
                                            child: ListTile(
                                              leading: Text('${index + 1}.)'),
                                              title: Text(
                                                snapshot.data
                                                    .upcomingContest[index],
                                                style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    decorationColor:
                                                        Colors.blueAccent),
                                              ),
                                            ),
                                          );
                                        })),
                              ])),
                          Container(
                              height: 240,
                              child: Column(
                                children: [
                                  Text(
                                    'Past Contests',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 2 * SizeConfig.safeBlockHorizontal,
                                  ),
                                  SizedBox(
                                      height: 200,
                                      child: ListView.builder(
                                          itemCount:
                                              snapshot.data.pastContest.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                                onTap: () {
                                                  launchUrl(Uri.parse(snapshot
                                                      .data
                                                      .pastContestLink[index]));
                                                },
                                                child: ListTile(
                                                  leading:
                                                      Text('${index + 1}.)'),
                                                  title: Text(
                                                    snapshot.data
                                                        .pastContest[index],
                                                    style: TextStyle(
                                                        color:
                                                            Colors.blueAccent,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        decorationColor:
                                                            Colors.blueAccent),
                                                  ),
                                                ));
                                          })),
                                ],
                              )),
                        ])));
          }
          else  {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }
        }
        );
  }
}
