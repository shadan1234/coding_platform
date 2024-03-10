import 'dart:convert';

import 'package:coding_platform/apis/api.dart';
import 'package:coding_platform/data/user_data.dart';
import 'package:coding_platform/pages/profile/profile.dart';
import 'package:coding_platform/size_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/user.dart';

class Me extends StatefulWidget {
  @override
  State<Me> createState() => _MeState();
}

class _MeState extends State<Me> {
  List<String>? listOfSubmissions;

  List<String>? upcomingContest;

  List<String>? pastContest;

  List<String>? pastContestLink;

  User? user;

  @override
  void initState() {
    // TODO: implement initState
    fetchContestList();
    fetchSubmissions();
    fetchUserData(context);
    // fetchDataFromProvider(context);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    fetchDataFromProvider(context);
  }

  void fetchDataFromProvider(BuildContext context) async {
    final userProvider=Provider.of<UserData>(context);
    // if(userProvider.isAdmin==true){
    //   userProvider.replace(userProvider.adminHandle);
    // }
    user = userProvider.user;


  }

  void fetchContestList() async {
    String url = UserData.BaseUrl + UserData.contestList;
    http.Response response = await http.get(Uri.parse(url));
    upcomingContest = [];
    pastContest = [];
    pastContestLink = [];

    List<dynamic> contestList = jsonDecode(response.body)['result'];
    // print(contestList);
    for (int i = 0; i < contestList.length; i++) {
      if (contestList[i]['phase'] == 'BEFORE') {
        upcomingContest?.add(contestList[i]['name']);

        // print(contestList[i]['name']);
      } else {
        pastContest?.add(contestList[i]['name']);
        pastContestLink
            ?.add('${UserData.BaseUrl}/contest/${contestList[i]['id']}');
      }
      setState(() {});
    }
  }

  void fetchSubmissions() async {
    String url = UserData.BaseUrl + UserData.userSubmissions;
    http.Response response = await http.get(Uri.parse(url));
    listOfSubmissions = [];
    List<dynamic> userSub = jsonDecode(response.body)['result'];
    for (int i = 0; i < userSub.length; i++) {
      String individualSub =
          '${UserData.BaseUrl}contest/${userSub[i]['contestId']}/submission/${userSub[i]['id']}';

      listOfSubmissions?.add(individualSub);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Codeforces'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FutureBuilder(
              future: Future.value(user),
              builder: (BuildContext context, snapshot) {
                // print(user);
                if (snapshot.hasData) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Profile()));
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage('${user?.avatar}'),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.refresh))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user?.rank ?? '...',
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
              Text(
                user?.handle ?? '...',
                style: TextStyle(color: Colors.grey, fontSize: 22),
              ),
              SizedBox(
                height: 4 * SizeConfig.safeBlockHorizontal,
              ),
              Text(
                  'Rating: ${user?.rating ?? '...'}, (max ${user?.maxRank ?? '...'}, ${user?.maxRating ?? '...'})'),
              SizedBox(
                height: SizeConfig.safeBlockHorizontal,
              ),
              Text('Contribution: ${user?.contribution ?? '...'}'),
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
                        child: FutureBuilder(
                          future: Future.value(listOfSubmissions),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              // print(user);
                              return ListView.builder(
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          launchUrl(
                                              Uri.parse(snapshot.data![index]));
                                        },
                                        child: ListTile(
                                          leading: Text('${index + 1}.)'),
                                          title: Text(
                                            snapshot.data![index],
                                            style: TextStyle(
                                                color: Colors.blueAccent,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor:
                                                    Colors.blueAccent),
                                          ),
                                        ));
                                  });
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('${snapshot.error}'),
                              );
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        )),
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
                        child: StreamBuilder(
                          // same thing either use FutureBuilder with setState or StreamBuilder without setState;
                          stream: Stream.value(upcomingContest),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              // print('hllo');
                              // print(snapshot.data);
                              return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        launchUrl(Uri.parse(
                                            'https://codeforces.com/contests'));
                                      },
                                      child: ListTile(
                                        leading: Text('${index + 1}.)'),
                                        title: Text(
                                          snapshot.data[index],
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor:
                                                  Colors.blueAccent),
                                        ),
                                      ),
                                    );
                                  });
                            } else if (snapshot.hasError) {
                              return Center(child: Text('${snapshot.error}'));
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        )),
                  ])),
              Container(
                  height: 240,
                  child: Column(children: [
                    Text(
                      'Past Contests',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 2 * SizeConfig.safeBlockHorizontal,
                    ),
                    SizedBox(
                        height: 200,
                        child: FutureBuilder(
                          future: Future.value(pastContest),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              // print(user);
                              return ListView.builder(
                                  itemCount: pastContest?.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          launchUrl(Uri.parse(
                                              pastContestLink![index]));
                                        },
                                        child: ListTile(
                                          leading: Text('${index + 1}.)'),
                                          title: Text(
                                            pastContest![index],
                                            style: TextStyle(
                                                color: Colors.blueAccent,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor:
                                                    Colors.blueAccent),
                                          ),
                                        ));
                                  });
                            } else if (snapshot.hasError) {
                              return Center(child: Text('${snapshot.error}'));
                            }
                            return Center(child: CircularProgressIndicator());
                          },
                        )),
                  ])),
            ],
          )),
    );
  }
}
