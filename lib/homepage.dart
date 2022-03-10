import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hot_search/model/websitedata.dart';
import 'package:hot_search/setting.dart';
import 'DataController.dart';
import 'card.dart';

class HomePage extends StatefulWidget {
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  DataController _dataController = Get.put(DataController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget logo(website) {
    if (website.website == '什么值得买') {
      return Image.network(
        'https://res.smzdm.com/resources/public/img/pc_global/logo.png',
        width: 100,
        height: 30,
      );
    } else if (website.website == '微博') {
      return Row(
        children: [
          Image.network(
            website.icon,
            height: 35,
            width: 35,
            color: website.website == '虎扑' ? Colors.red : null,
          ),
          Text(
            '\r${website.website}',
            style: TextStyle(fontSize: 17),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Image.network(
            website.icon,
            height: 25,
            width: 25,
            color: website.website == '虎扑' ? Colors.red : null,
          ),
          Text(
            '\r\r${website.website}',
            style: TextStyle(fontSize: 17),
          ),
        ],
      );
    }
  }

  List<Tab> TabList() {
    List<Tab> Tabs = <Tab>[];
    for (var item in _dataController.websiteList) {
      websitedata website = websitedata.fromJson(item);
      Tabs.add(
        Tab(
          text: website.website,
        ),
      );
    }
    return Tabs;
  }

  List<Widget> CardList() {
    List<Widget> Cards = [];
    for (int i = 0; i < _dataController.websiteList.length; i++) {
      websitedata website =
          websitedata.fromJson(_dataController.websiteList[i]);
      Cards.add(
        DataCard(
          logo: logo(website),
          listname: website.menu,
          website: website.website,
          data: _dataController.hotsearchData,
          model: _dataController.model.value,
        ),
      );
    }
    return Cards;
  }

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      return DefaultTabController(
          length: _dataController.websiteList.length,
          child: Builder(
            builder: (BuildContext context) {

              TabController tabController;
              tabController = DefaultTabController.of(context);
              tabController.addListener(() {
                //   //解决对TabController的监听在点击Tab后会执行两次和监听滑动
                if (tabController.index.toDouble() ==
                    tabController.animation.value) {
                  print(tabController.index);
                  _dataController.updatetabindex(tabController.index);
                  //滑动后获取到weblist中的数据
                  websitedata website = websitedata.fromJson(
                      _dataController.websiteList[tabController.index]);
                  //默认滑动后获取第一个子菜单的数据
                  _dataController.updateData(website.menu[0].menuUrl);
                }
              });
              return Scaffold(
                  appBar: AppBar(
                    elevation: 2,
                    centerTitle: true,
                    title: Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        '今日热搜',
                        style: TextStyle(color: Color(0xFFFE1483)),
                      ),
                    ),
                    actions: [
                      Builder(builder: (BuildContext context) {
                        return GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Text(
                              '···',
                              style: TextStyle(
                                  color: Color(0xFFFE1483), fontSize: 30),
                            ),
                          ),
                          onTap: () async {
                            var result = await Get.to(Setting(),
                                transition: Transition.noTransition);
                            if(result !=null){
                              websitedata websites = websitedata.fromJson(
                                  _dataController.websiteList[0]);
                              print(websites.menu[0].menuUrl);
                              _dataController.updateData(websites.menu[0].menuUrl);
                            }
                          },
                        );
                      }),
                    ],
                    backgroundColor: Colors.white,
                    bottom: PreferredSize(
                      preferredSize: Size(double.infinity, 20),
                      child: TabBar(
                          indicatorColor: Color(0xFFFE1483),
                          labelColor: Color(0xFFFE1483),
                          unselectedLabelColor: Colors.black54,
                          isScrollable: true,
                          indicatorSize: TabBarIndicatorSize.label,
                          tabs: TabList()),
                    ),
                  ),
                  body: TabBarView(
                    children: CardList(),
                  ));
            },
          ));
    });
  }
}
