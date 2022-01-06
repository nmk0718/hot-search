class sspai {
  int error;
  String msg;
  dynamic data;
  int total;

  sspai({this.error, this.msg, this.data, this.total});

  sspai.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    msg = json['msg'];
    data = json['data'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['msg'] = this.msg;
    data['data'] = this.data;
    data['total'] = this.total;
    return data;
  }
}
