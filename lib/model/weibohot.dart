class weibohot {
  int ok;
  int httpCode;
  Data data;

  weibohot({this.ok, this.httpCode, this.data});

  weibohot.fromJson(Map<String, dynamic> json) {
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
  dynamic bandList;

  Data({this.bandList});

  Data.fromJson(Map<String, dynamic> json) {
    bandList = json['band_list'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['band_list'] = this.bandList;
    return data;
  }
}