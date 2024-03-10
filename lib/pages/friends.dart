import 'package:coding_platform/data/friends_data.dart';
import 'package:coding_platform/data/user_data.dart';
import 'package:coding_platform/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'me.dart';

class Friends extends StatefulWidget {
  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  TextEditingController controller = TextEditingController();
List<String> friends=[];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
  final friendsData=Provider.of<FriendsData>(context);
  friends=friendsData.friends;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Friends'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.safeBlockHorizontal,
                ),
                TextFormField(
                  onTap: () {},
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: 'Search your Friends',
                      contentPadding: EdgeInsets.all(14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
                SizedBox(
                  height: 2 * SizeConfig.safeBlockHorizontal,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        friends.add(controller.text);
                        controller.clear();
                      });
                    },
                    child: Text('Submit')),
                SizedBox(
                  height: 2 * SizeConfig.safeBlockHorizontal,
                ),
                SizedBox(
                  height: 125 * SizeConfig.safeBlockHorizontal,
                  child: ListView.builder(
                    itemCount: friends.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: (){
                            final userProvider= Provider.of<UserData>(context,listen: false);
                            // userProvider.isAdmin=false;
                            userProvider.replace(friends[index]);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Me()));
                        },
                        child: ListTile(
                          leading: Text('${(index + 1)}'),
                          title: Text(friends[index]),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
