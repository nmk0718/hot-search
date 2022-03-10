class weibotopic {
  int ok;
  int httpCode;
  Data data;

  weibotopic({this.ok, this.httpCode, this.data});

  weibotopic.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    httpCode = json['http_code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    data['http_code'] = this.httpCode;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  dynamic statuses;

  Data({this.statuses});

  Data.fromJson(Map<String, dynamic> json) {
    statuses = json['statuses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statuses'] = this.statuses;
    return data;
  }
}