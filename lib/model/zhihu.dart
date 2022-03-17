class zhihu {
  List<Data> data;
  Paging paging;

  zhihu({this.data, this.paging});

  zhihu.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    paging =
    json['paging'] != null ? new Paging.fromJson(json['paging']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.paging != null) {
      data['paging'] = this.paging.toJson();
    }
    return data;
  }
}

class Data {
  Question question;
  Reaction reaction;

  Data({this.question, this.reaction});

  Data.fromJson(Map<String, dynamic> json) {
    question = json['question'] != null
        ? new Question.fromJson(json['question'])
        : null;
    reaction = json['reaction'] != null
        ? new Reaction.fromJson(json['reaction'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.question != null) {
      data['question'] = this.question.toJson();
    }
    if (this.reaction != null) {
      data['reaction'] = this.reaction.toJson();
    }
    return data;
  }
}

class Question {
  String url;
  int created;
  int updatedTime;
  String title;
  String highlightTitle;
  String type;
  String id;
  int token;
  bool isRecentHot;
  bool haveAnswer;
  String questionAnswerUrl;
  List<Topics> topics;
  String label;
  Creator creator;

  Question(
      {this.url,
        this.created,
        this.updatedTime,
        this.title,
        this.highlightTitle,
        this.type,
        this.id,
        this.token,
        this.isRecentHot,
        this.haveAnswer,
        this.questionAnswerUrl,
        this.topics,
        this.label,
        this.creator});

  Question.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    created = json['created'];
    updatedTime = json['updated_time'];
    title = json['title'];
    highlightTitle = json['highlight_title'];
    type = json['type'];
    id = json['id'];
    token = json['token'];
    isRecentHot = json['is_recent_hot'];
    haveAnswer = json['have_answer'];
    questionAnswerUrl = json['question_answer_url'];
    if (json['topics'] != null) {
      topics = <Topics>[];
      json['topics'].forEach((v) {
        topics.add(new Topics.fromJson(v));
      });
    }
    label = json['label'];
    creator =
    json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['created'] = this.created;
    data['updated_time'] = this.updatedTime;
    data['title'] = this.title;
    data['highlight_title'] = this.highlightTitle;
    data['type'] = this.type;
    data['id'] = this.id;
    data['token'] = this.token;
    data['is_recent_hot'] = this.isRecentHot;
    data['have_answer'] = this.haveAnswer;
    data['question_answer_url'] = this.questionAnswerUrl;
    if (this.topics != null) {
      data['topics'] = this.topics.map((v) => v.toJson()).toList();
    }
    data['label'] = this.label;
    if (this.creator != null) {
      data['creator'] = this.creator.toJson();
    }
    return data;
  }
}

class Topics {
  int urlToken;
  String name;

  Topics({this.urlToken, this.name});

  Topics.fromJson(Map<String, dynamic> json) {
    urlToken = json['url_token'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url_token'] = this.urlToken;
    data['name'] = this.name;
    return data;
  }
}

class Creator {
  String urlToken;
  String name;

  Creator({this.urlToken, this.name});

  Creator.fromJson(Map<String, dynamic> json) {
    urlToken = json['url_token'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url_token'] = this.urlToken;
    data['name'] = this.name;
    return data;
  }
}

class Reaction {
  int newPv;
  int newPv7Days;
  int newFollowNum;
  int newFollowNum7Days;
  int newAnswerNum;
  int newAnswerNum7Days;
  int newUpvoteNum;
  int newUpvoteNum7Days;
  int pv;
  int followNum;
  int answerNum;
  int upvoteNum;
  String pvIncrRate;
  String headPercent;
  int newPvYesterday;
  int newPvTYesterday;
  dynamic score;
  dynamic scoreLevel;
  String text;

  Reaction(
      {this.newPv,
        this.newPv7Days,
        this.newFollowNum,
        this.newFollowNum7Days,
        this.newAnswerNum,
        this.newAnswerNum7Days,
        this.newUpvoteNum,
        this.newUpvoteNum7Days,
        this.pv,
        this.followNum,
        this.answerNum,
        this.upvoteNum,
        this.pvIncrRate,
        this.headPercent,
        this.newPvYesterday,
        this.newPvTYesterday,
        this.score,
        this.scoreLevel,
        this.text});

  Reaction.fromJson(Map<String, dynamic> json) {
    newPv = json['new_pv'];
    newPv7Days = json['new_pv_7_days'];
    newFollowNum = json['new_follow_num'];
    newFollowNum7Days = json['new_follow_num_7_days'];
    newAnswerNum = json['new_answer_num'];
    newAnswerNum7Days = json['new_answer_num_7_days'];
    newUpvoteNum = json['new_upvote_num'];
    newUpvoteNum7Days = json['new_upvote_num_7_days'];
    pv = json['pv'];
    followNum = json['follow_num'];
    answerNum = json['answer_num'];
    upvoteNum = json['upvote_num'];
    pvIncrRate = json['pv_incr_rate'];
    headPercent = json['head_percent'];
    newPvYesterday = json['new_pv_yesterday'];
    newPvTYesterday = json['new_pv_t_yesterday'];
    score = json['score'];
    scoreLevel = json['score_level'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['new_pv'] = this.newPv;
    data['new_pv_7_days'] = this.newPv7Days;
    data['new_follow_num'] = this.newFollowNum;
    data['new_follow_num_7_days'] = this.newFollowNum7Days;
    data['new_answer_num'] = this.newAnswerNum;
    data['new_answer_num_7_days'] = this.newAnswerNum7Days;
    data['new_upvote_num'] = this.newUpvoteNum;
    data['new_upvote_num_7_days'] = this.newUpvoteNum7Days;
    data['pv'] = this.pv;
    data['follow_num'] = this.followNum;
    data['answer_num'] = this.answerNum;
    data['upvote_num'] = this.upvoteNum;
    data['pv_incr_rate'] = this.pvIncrRate;
    data['head_percent'] = this.headPercent;
    data['new_pv_yesterday'] = this.newPvYesterday;
    data['new_pv_t_yesterday'] = this.newPvTYesterday;
    data['score'] = this.score;
    data['score_level'] = this.scoreLevel;
    data['text'] = this.text;
    return data;
  }
}

class Paging {
  bool isEnd;
  bool isStart;
  String next;
  String previous;
  int totals;

  Paging({this.isEnd, this.isStart, this.next, this.previous, this.totals});

  Paging.fromJson(Map<String, dynamic> json) {
    isEnd = json['is_end'];
    isStart = json['is_start'];
    next = json['next'];
    previous = json['previous'];
    totals = json['totals'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_end'] = this.isEnd;
    data['is_start'] = this.isStart;
    data['next'] = this.next;
    data['previous'] = this.previous;
    data['totals'] = this.totals;
    return data;
  }
}