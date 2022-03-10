class hupu {
  int code;
  String message;
  Data data;

  hupu({this.code, this.message, this.data});

  hupu.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    message = json['Message'];
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Code'] = this.code;
    data['Message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<hupuData> data;
  String page;

  Data({this.data, this.page});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <hupuData>[];
      json['data'].forEach((v) {
        data.add(new hupuData.fromJson(v));
      });
    }
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    return data;
  }
}

class hupuData {
  int id;
  int createTime;
  int commentNum;
  int approvalNum;
  String title;
  String hotDesc;
  String url;
  String imgUrl;
  String isRss;
  int isAgree;
  String typeName;

  hupuData(
      {this.id,
        this.createTime,
        this.commentNum,
        this.approvalNum,
        this.title,
        this.hotDesc,
        this.url,
        this.imgUrl,
        this.isRss,
        this.isAgree,
        this.typeName});

  hupuData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = json['CreateTime'];
    commentNum = json['commentNum'];
    approvalNum = json['approvalNum'];
    title = json['Title'];
    hotDesc = json['hotDesc'];
    url = json['Url'];
    imgUrl = json['imgUrl'];
    isRss = json['isRss'];
    isAgree = json['is_agree'];
    typeName = json['TypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['CreateTime'] = this.createTime;
    data['commentNum'] = this.commentNum;
    data['approvalNum'] = this.approvalNum;
    data['Title'] = this.title;
    data['hotDesc'] = this.hotDesc;
    data['Url'] = this.url;
    data['imgUrl'] = this.imgUrl;
    data['isRss'] = this.isRss;
    data['is_agree'] = this.isAgree;
    data['TypeName'] = this.typeName;
    return data;
  }
}