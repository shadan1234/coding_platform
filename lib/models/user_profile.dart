class UserProfile {
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

  UserProfile(
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
  UserProfile.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    country = json['country'];
    rating = json['rating'];
    friendOfCount = json['friendOfCount'];
    titlePhoto = json['titlePhoto'];
    handle = json['handle'];
    avatar = json['avatar'];
    contribution = json['contribution'];
    organization = json['organization'];
    rank = json['rank'];
    maxRating = json['maxRating'];
    maxRank = json['maxRank'];
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
