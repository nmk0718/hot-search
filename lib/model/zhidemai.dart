class zhidemai {
  int errorCode;
  String errorMsg;
  Data data;

  zhidemai({this.errorCode, this.errorMsg, this.data});

  zhidemai.fromJson(Map<String, dynamic> json) {
    errorCode = json['error_code'];
    errorMsg = json['error_msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error_code'] = this.errorCode;
    data['error_msg'] = this.errorMsg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  dynamic list;
  dynamic timeSlot;

  Data({this.list, this.timeSlot});

  Data.fromJson(Map<String, dynamic> json) {

    list = json['list'];
    timeSlot = json['time_slot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['list'] = this.list;
    data['time_slot'] = this.timeSlot;
    return data;
  }
}