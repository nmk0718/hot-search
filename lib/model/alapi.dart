class alapi {
  int code;
  String msg;
  Data data;
  int time;
  int logId;

  alapi({this.code, this.msg, this.data, this.time, this.logId});

  alapi.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    time = json['time'];
    logId = json['log_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['time'] = this.time;
    data['log_id'] = this.logId;
    return data;
  }
}

class Data {
  String name;
  String lastUpdate;
  List<DataList> list;

  Data({this.name, this.lastUpdate, this.list});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lastUpdate = json['last_update'];
    if (json['list'] != null) {
      list = new List<DataList>();
      json['list'].forEach((v) {
        list.add(new DataList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['last_update'] = this.lastUpdate;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataList {
  String title;
  String link;
  String other;

  DataList({this.title, this.link, this.other});

  DataList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'];
    other = json['other'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['link'] = this.link;
    data['other'] = this.other;
    return data;
  }
}