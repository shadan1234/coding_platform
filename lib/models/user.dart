import 'dart:convert';

class User {
  int? isAdmin;
  String? lastName;
  String? firstName;
  String? country;
  int? rating;
  int? friendOfCount;
  String? titlePhoto;
  String? handle;
  String? avatar;
  int? contribution;
  String? organization;
  String? rank;
  int? maxRating;
  String? maxRank;
  List<String>? upcomingContest;
  List<String>? pastContest;
  List<String>? pastContestLink;
  List<String>? recentSubmission;

  User({
    this.isAdmin,
    this.firstName,
    this.lastName,
    this.rating,
    this.avatar,
    this.contribution,
    this.country,
    this.friendOfCount,
    this.handle,
    this.maxRank,
    this.maxRating,
    this.organization,
    this.rank,
    this.titlePhoto,
    List<String>? upcomingContest,
    List<String>? pastContest,
    List<String>? pastContestLink,
    List<String>? recentSubmission,
  }) {
    // Serialize lists to JSON strings
    this.upcomingContest = upcomingContest;
    this.pastContest = pastContest;
    this.pastContestLink = pastContestLink;
    this.recentSubmission = recentSubmission;
  }

  User.fromMap(Map<String, dynamic> map)
      : isAdmin = map['isAdmin'],
        firstName = map['firstName'],
        lastName = map['lastName'],
        country = map['country'],
        rating = map['rating'],
        friendOfCount = map['friendOfCount'],
        titlePhoto = map['titlePhoto'],
        handle = map['handle'],
        avatar = map['avatar'],
        contribution = map['contribution'],
        organization = map['organization'],
        rank = map['rank'],
        maxRating = map['maxRating'],
        maxRank = map['maxRank'],
        upcomingContest = map['upcomingContest'] != null ? List<String>.from(jsonDecode(map['upcomingContest'])) : null,
        pastContest = map['pastContest'] != null ? List<String>.from(jsonDecode(map['pastContest'])) : null,
        pastContestLink = map['pastContestLink'] != null ? List<String>.from(jsonDecode(map['pastContestLink'])) : null,
        recentSubmission = map['recentSubmission'] != null ? List<String>.from(jsonDecode(map['recentSubmission'])) : null;

  Map<String, dynamic> toMap() {
    return {
      'isAdmin': isAdmin,
      'firstName': firstName,
      'lastName': lastName,
      'country': country,
      'rating': rating,
      'friendOfCount': friendOfCount,
      'titlePhoto': titlePhoto,
      'handle': handle,
      'avatar': avatar,
      'contribution': contribution,
      'organization': organization,
      'rank': rank,
      'maxRating': maxRating,
      'maxRank': maxRank,
      'upcomingContest': upcomingContest != null ? jsonEncode(upcomingContest) : null,
      'pastContest': pastContest != null ? jsonEncode(pastContest) : null,
      'pastContestLink': pastContestLink != null ? jsonEncode(pastContestLink) : null,
      'recentSubmission': recentSubmission != null ? jsonEncode(recentSubmission) : null,
    };
  }
}
