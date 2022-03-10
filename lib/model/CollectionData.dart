class CollectionData {
  String website;
  String subject;
  String link;

  CollectionData({this.website,this.subject,this.link});

  CollectionData.fromJson(Map<String, dynamic> json) {
    website = json['website'];
    subject = json['subject'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['website'] = this.website;
    data['subject'] = this.subject;
    data['link'] = this.link;
    return data;
  }
}