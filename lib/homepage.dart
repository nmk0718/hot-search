import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  PageController _pageController = PageController(viewportFraction: 0.9999);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
      Cards.add(
        DataCard(),
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
              TabController tabController = DefaultTabController.of(context);
              return Scaffold(
                  appBar: AppBar(
                    elevation: 2,
                    centerTitle: true,
                    title: Container(
                      child: Text(
                        '今日热搜',
                      ),
                    ),
                    actions: [
                      Builder(builder: (BuildContext context) {
                        return GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.only(right: 15),
                          child: Text(
                            '···',
                            style: TextStyle(fontSize: 30),
                          ),
                          ),
                          onTap: () {
                            Get.to(Setting(),
                                transition: Transition.noTransition);
                            // var result = await Get.to(Setting(),
                            //     transition: Transition.noTransition);
                            // if(result !=null){
                            //   websitedata websites = websitedata.fromJson(
                            //       _dataController.websiteList[tabController.index]);
                            //   _dataController.updateData(websites.menu[0].menuUrl);
                            // }
                          },
                        );
                      }),
                    ],
                    // backgroundColor: Colors.white,
                    bottom: PreferredSize(
                      preferredSize: Size(double.infinity, 20),
                      child: TabBar(
                          isScrollable: true,
                          indicatorSize: TabBarIndicatorSize.label,
                          tabs: TabList(),
                        onTap: (index){
                            _pageController.jumpToPage(index);

                        },
                      ),
                    ),
                  ),
                  body: PageView(
                    controller: _pageController,
                    children: CardList(),
                    onPageChanged: (index){
                      _dataController.hotsearchData.clear();
                      _dataController.updatetabindex(index);
                      //滑动后获取到weblist中的数据
                      websitedata website = websitedata.fromJson(
                          _dataController.websiteList[index]);
                      //默认滑动后获取第一个子菜单的数据
                      _dataController.updateData(website.menu[0].menuUrl);
                     tabController.animateTo(index);
                    },
                  ));
            },
          ));
    });
  }
}
