class User {
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

  User(
      {this.firstName,
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
      this.titlePhoto});

  // factory constructor special type of constructor directly returns object of User
  User.fromJson(Map<String, dynamic> json) {
    firstName = json['result'][0]['firstName'];
    lastName = json['result'][0]['lastName'];
    country = json['result'][0]['country'];
    rating = json['result'][0]['rating'];
    friendOfCount = json['result'][0]['friendOfCount'];
    titlePhoto = json['result'][0]['titlePhoto'];
    handle = json['result'][0]['handle'];
    avatar = json['result'][0]['avatar'];
    contribution = json['result'][0]['contribution'];
    organization = json['result'][0]['organization'];
    rank = json['result'][0]['rank'];
    maxRating = json['result'][0]['maxRating'];
    maxRank = json['result'][0]['maxRank'];
  }

  Map<String, dynamic> toJson() {
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
    };
  }
}
