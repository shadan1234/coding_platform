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
    required this.upcomingContest,
    required this.pastContest,
    required this.pastContestLink,
    required this.recentSubmission,
  });

  User.fromMap(Map<String, dynamic> map)
      : firstName = map['firstName'],
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
        upcomingContest = List<String>.from(map['upcomingContest']),
        pastContest = List<String>.from(map['pastContest']),
        pastContestLink = List<String>.from(map['pastContestLink']),
        recentSubmission = List<String>.from(map['recentSubmission']);

  Map<String, dynamic> toMap() {
    return {
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
      'upcomingContest': upcomingContest,
      'pastContest': pastContest,
      'pastContestLink': pastContestLink,
      'recentSubmission': recentSubmission,
    };
  }
}
