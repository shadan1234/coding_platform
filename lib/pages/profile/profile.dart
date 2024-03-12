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
  User? user;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final _userData = Provider.of<UserData>(context, listen: false);
    user = _userData.user;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
              backgroundImage: NetworkImage(user?.avatar ??
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
                  '${user?.firstName} ${user?.lastName}' ?? '...',
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
                    '${user?.organization}',
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
                  '${user!.country}',
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
                  '${user?.contribution}',
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
                  '${user?.rating}',
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
                  '${user?.maxRating}',
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
  }
}
