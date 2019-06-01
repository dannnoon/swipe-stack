class Questions {
  List<Items> items;
  bool hasMore;
  int quotaMax;
  int quotaRemaining;

  Questions({this.items, this.hasMore, this.quotaMax, this.quotaRemaining});

  Questions.fromJson(Map<dynamic, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    hasMore = json['has_more'];
    quotaMax = json['quota_max'];
    quotaRemaining = json['quota_remaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['has_more'] = this.hasMore;
    data['quota_max'] = this.quotaMax;
    data['quota_remaining'] = this.quotaRemaining;
    return data;
  }
}

class Items {
  List<String> tags;
  Owner owner;
  bool isAnswered;
  int viewCount;
  int answerCount;
  int score;
  int lastActivityDate;
  int creationDate;
  int questionId;
  String link;
  String title;

  Items(
      {this.tags,
        this.owner,
        this.isAnswered,
        this.viewCount,
        this.answerCount,
        this.score,
        this.lastActivityDate,
        this.creationDate,
        this.questionId,
        this.link,
        this.title});

  Items.fromJson(Map<String, dynamic> json) {
    tags = json['tags'].cast<String>();
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    isAnswered = json['is_answered'];
    viewCount = json['view_count'];
    answerCount = json['answer_count'];
    score = json['score'];
    lastActivityDate = json['last_activity_date'];
    creationDate = json['creation_date'];
    questionId = json['question_id'];
    link = json['link'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tags'] = this.tags;
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    data['is_answered'] = this.isAnswered;
    data['view_count'] = this.viewCount;
    data['answer_count'] = this.answerCount;
    data['score'] = this.score;
    data['last_activity_date'] = this.lastActivityDate;
    data['creation_date'] = this.creationDate;
    data['question_id'] = this.questionId;
    data['link'] = this.link;
    data['title'] = this.title;
    return data;
  }
}

class Owner {
  int reputation;
  int userId;
  String userType;
  int acceptRate;
  String profileImage;
  String displayName;
  String link;

  Owner(
      {this.reputation,
        this.userId,
        this.userType,
        this.acceptRate,
        this.profileImage,
        this.displayName,
        this.link});

  Owner.fromJson(Map<String, dynamic> json) {
    reputation = json['reputation'];
    userId = json['user_id'];
    userType = json['user_type'];
    acceptRate = json['accept_rate'];
    profileImage = json['profile_image'];
    displayName = json['display_name'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reputation'] = this.reputation;
    data['user_id'] = this.userId;
    data['user_type'] = this.userType;
    data['accept_rate'] = this.acceptRate;
    data['profile_image'] = this.profileImage;
    data['display_name'] = this.displayName;
    data['link'] = this.link;
    return data;
  }
}
