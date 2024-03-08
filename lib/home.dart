import 'dart:convert';

import 'package:coding_platform/apis/api.dart';
import 'package:coding_platform/profile/profile.dart';
import 'package:coding_platform/size_config.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'models/user.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> listOfSubmissions = [];

  List<String> upcomingContest = [];
  List<String> pastContest = [];

  List<String> pastContestLink = [];
  User? user;
  @override
  void initState() {
    // TODO: implement initState
    fetchContestList();
    fetchSubmissions();
    super.initState();
  }

  void fetchContestList() async {
    String url = Api.BaseUrl + Api.contestList;
    http.Response response = await http.get(Uri.parse(url));
    List<dynamic> contestList = jsonDecode(response.body)['result'];
    // print(contestList);
    for (int i = 0; i < contestList.length; i++) {
      if (contestList[i]['phase'] == 'BEFORE') {
        upcomingContest.add(contestList[i]['name']);

        // print(contestList[i]['name']);
      } else {
        pastContest.add(contestList[i]['name']);
        pastContestLink.add('${Api.BaseUrl}/contest/${contestList[i]['id']}');
      }
      setState(() {});
    }
  }

  void fetchSubmissions() async {
    String url = Api.BaseUrl + Api.userSubmissions;
    http.Response response = await http.get(Uri.parse(url));
    List<dynamic> userSub = jsonDecode(response.body)['result'];
    for (int i = 0; i < userSub.length; i++) {
      String individualSub =
          '${Api.BaseUrl}contest/${userSub[i]['contestId']}/submission/${userSub[i]['id']}';

      listOfSubmissions.add(individualSub);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Codeforces'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              },
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage('https://userpic.codeforces.org/no-title.jpg'),
              ),
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
                'Newbie',
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
              Text(
                'shadan122',
                style: TextStyle(color: Colors.grey, fontSize: 22),
              ),
              SizedBox(
                height: 4 * SizeConfig.safeBlockHorizontal,
              ),
              Text('Rating: 1200, (max newbie, 1032)'),
              SizedBox(
                height: SizeConfig.safeBlockHorizontal,
              ),
              Text('Contribution: 0'),
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
                          builder: (BuildContext context,
                              AsyncSnapshot<List<String>> snapshot) {
                            if (snapshot.hasData) {
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
                        child: FutureBuilder<List<String>>(
                          future: Future.value(upcomingContest),
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
                          builder: (BuildContext context,
                              AsyncSnapshot<List<String>> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: pastContest.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          launchUrl(Uri.parse(
                                              pastContestLink[index]));
                                        },
                                        child: ListTile(
                                          leading: Text('${index + 1}.)'),
                                          title: Text(
                                            pastContest[index],
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
