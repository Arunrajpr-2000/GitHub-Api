class UserModel {
  String? username;
  String? imageUrl;
  String? bio;
  int? followers;
  int? followings;
  int? publicRepo;
  String? joiningDate;
  String? location;
  String? email;

  UserModel(
      {this.username,
      this.imageUrl,
      this.bio,
      this.followers,
      this.followings,
      this.joiningDate,
      this.publicRepo,
      this.location,
      this.email});

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['name'];
    bio = json['bio'];
    imageUrl = json['avatar_url'];
    followers = json['followers'];
    followings = json['following'];
    joiningDate = json['created_at'];
    publicRepo = json['public_repos'];
    location = json['location'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.username;
    data['bio'] = this.bio;
    data['avatar_url'] = this.imageUrl;
    data['followers'] = this.followers;
    data['following'] = this.followings;
    data['created_at'] = this.joiningDate;
    data['public_repos'] = this.publicRepo;
    data['location'] = this.location;
    data['email'] = this.email;

    return data;
  }
}
