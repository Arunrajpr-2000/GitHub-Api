class RepoModel {
  String? reponame;

  int? starcount;
  int? forkscount;

  RepoModel({
    this.reponame,
    this.starcount,
    this.forkscount,
  });

  RepoModel.fromJson(Map<String, dynamic> json) {
    reponame = json['name'];
    starcount = json['stargazers_count'];
    forkscount = json['forks_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.reponame;
    data['stargazers_count'] = this.starcount;
    data['forks_count'] = this.forkscount;

    return data;
  }
}
