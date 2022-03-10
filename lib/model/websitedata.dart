class websitedata {
  String website;
  String icon;
  List<Menu> menu;

  websitedata({this.website,this.icon,this.menu});

  websitedata.fromJson(Map<String, dynamic> json) {
    website = json['website'];
    icon = json['icon'];
    if (json['menu'] != null) {
      menu = <Menu>[];
      json['menu'].forEach((v) {
        menu.add(new Menu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['website'] = this.website;
    data['icon'] = this.icon;
    if (this.menu != null) {
      data['menu'] = this.menu.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Menu {
  String menuName;
  String menuUrl;

  Menu({this.menuName, this.menuUrl});

  Menu.fromJson(Map<String, dynamic> json) {
    menuName = json['menuName'];
    menuUrl = json['menuUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menuName'] = this.menuName;
    data['menuUrl'] = this.menuUrl;
    return data;
  }
}