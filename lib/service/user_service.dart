import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../data/user_data.dart';
import '../models/user_profile.dart';
import '../models/user.dart';

class UserService {
 // Create an instance of UserData
  Future<User> fetchUserDataFromAPI(String handle,BuildContext context) async {
    final _userData=Provider.of<UserData>(context,listen: false);
    final userProfile = await _fetchUserDetails(_userData.userInfoUrl);
    final contestsData = await fetchContests(context);
    final upcomingContests = contestsData['upcoming'];
    final pastContests = contestsData['past'];
    final pastContestLinks = contestsData['pastContestLinks'];
    final recentSubmissions =
        await _fetchRecentSubmissions(_userData.userSubmissionsUrl);

    User user= User(
      firstName: userProfile.firstName,
      lastName: userProfile.lastName,
      country: userProfile.country,
      rating: userProfile.rating,
      friendOfCount: userProfile.friendOfCount,
      titlePhoto: userProfile.titlePhoto,
      handle: userProfile.handle,
      avatar: userProfile.avatar,
      contribution: userProfile.contribution,
      organization: userProfile.organization,
      rank: userProfile.rank,
      maxRating: userProfile.maxRating,
      maxRank: userProfile.maxRank,
      upcomingContest: upcomingContests,
      pastContest: pastContests,
      pastContestLink: pastContestLinks,
      recentSubmission: recentSubmissions,
    );
    _userData.user=user;
    return user;
  }

  Future<UserProfile> _fetchUserDetails(String url) async {
    // print(url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // print(response.body);
      final decodedJson=jsonDecode(response.body)as Map<String,dynamic>;
      // print(decodedJson['result'][0]);
      return UserProfile.fromJson(decodedJson['result'][0]);
    } else {
      throw Exception('Failed to fetch user details');
    }
  }

  Future<Map<String, List<String>>> fetchContests(BuildContext context) async {
    final List<String> upcomingContests = [];
    final List<String> pastContests = [];
    final List<String> pastContestLinks = [];
    final _userData=Provider.of<UserData>(context,listen: false);
    final url = _userData.contestListUrl;
    // print(url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // print(response.body);
      final contests = jsonDecode(response.body)['result'];

      contests.forEach((contest) {
        if (contest['phase'] == 'BEFORE') {
          upcomingContests.add(contest['name']);
        } else {
          pastContests.add(contest['name']);
          pastContestLinks.add('${UserData.baseUrl}/contest/${contest['id']}');
        }
      });
    } else {
      throw Exception('Failed to fetch contests');
    }

    return {
      'upcoming': upcomingContests,
      'past': pastContests,
      'pastContestLinks': pastContestLinks,
    };
  }

  Future<List<String>> _fetchRecentSubmissions(String url) async {
    // Fetch recent submissions from API
    http.Response response = await http.get(Uri.parse(url));
    // print(response.body);
    List<dynamic> userSub = jsonDecode(response.body)['result'];

    List<String> listOfSubmissions = [];
    for (int i = 0; i < userSub.length; i++) {
      String individualSub =
          '${UserData.baseUrl}contest/${userSub[i]['contestId']}/submission/${userSub[i]['id']}';

      listOfSubmissions.add(individualSub);
    }

    return listOfSubmissions;
  }
}
