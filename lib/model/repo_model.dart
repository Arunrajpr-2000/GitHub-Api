class RepoModel {
  String? reponame;
  String? repoUrl;
  int? starcount;
  int? forkscount;

  RepoModel({
    this.reponame,
    this.repoUrl,
    this.starcount,
    this.forkscount,
  });

  RepoModel.fromJson(Map<String, dynamic> json) {
    reponame = json['name'];
    starcount = json['stargazers_count'];
    forkscount = json['forks_count'];
    repoUrl = json['svn_url'];
  }
}
