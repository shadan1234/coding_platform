import 'package:coding_platform/data/friends_data.dart';
import 'package:coding_platform/data/user_data.dart';
import 'package:coding_platform/database/database_helper.dart';
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
late  Future<List<String>?> friends;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }


  Future<List<String>?> fetchFriendsList() async{
    final databaseHelper=DatabaseHelper();
    final friendsData=Provider.of<FriendsData>(context);
    List<String>? friendsFromDb=await databaseHelper.getFriendsUsers();
    friendsData.friends=friendsFromDb;
    return friendsFromDb;
  }
  void insertFriendsHandle()async{
    final databaseHelper=DatabaseHelper();
   await databaseHelper.insertFriendsUser(controller.text);
  }
@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
  friends= fetchFriendsList();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: friends,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }else if(snapshot.hasError){
          return Center(child: Text('${snapshot.error}'),);
        }else{
          List<String>? friendsList = snapshot.data;
          friendsList ??= []; // Initialize as empty list if null

          return  Scaffold(
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
                            insertFriendsHandle();
                            setState(() {

                              friendsList?.add(controller.text);
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
                          itemCount: friendsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: (){
                                final _userData= Provider.of<UserData>(context,listen: false);
                                _userData.userHandle=friendsList?[index];
                                // userProvider.replace(friends[index]);
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Me()));
                              },
                              child: ListTile(
                                leading: Text('${(index + 1)}'),
                                title: Text(friendsList![index]),
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
      },

    );
  }
}
