import 'package:coding_platform/data/user_data.dart';
import 'package:coding_platform/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? userData;

  void fetchDataFromProvider(BuildContext context) {
    print('s');
    userData = Provider.of<UserData>(context, listen: false).user;
    print('who');
    // also could have done that in init State i could have called the api function and in api function returned the user and stored the user in my user variable which is in this class .
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    fetchDataFromProvider(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.value(userData),
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
                    backgroundImage: NetworkImage(snapshot.data.avatar ??
                        'https://userpic.codeforces.org/no-avatar.jpg'),
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
                        '${snapshot.data.firstName} ${snapshot.data.lastName}' ??
                            '...',
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
                      Flexible(
                        child: Text(
                          snapshot.data.organization,
                          softWrap: true,
                          style: TextStyle(fontSize: 14),
                        ),
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
