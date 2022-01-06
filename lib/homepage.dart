import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DataController.dart';
import 'card.dart';

class HomePage extends StatefulWidget {
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  DataController _dataController = Get.put(DataController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          centerTitle: true,
          title: Text(
            '今日热搜',
            style: TextStyle(color: Color(0xFFFE1483)),
          ),
          backgroundColor: Colors.white,
          bottom: TabBar(
            onTap: (index) {
              if(index ==1){
                if(_dataController.zhidemaiData.length <1){
                  _dataController.zhidemaiList();
                }
              }else if (index ==2){
                if(_dataController.pojieData.length<1){
                  _dataController.alapiList('NKGoRAzel6');
                }
              }
            },
            indicatorColor: Color(0xFFFE1483),
            labelColor: Color(0xFFFE1483),
            unselectedLabelColor: Colors.black54,
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: <Widget>[
              Tab(
                text: "少数派",
              ),
              Tab(
                text: "什么值得买",
              ),
              Tab(
                text: "吾爱破解",
              ),
              Tab(
                text: "虎扑",
              ),
              Tab(
                text: "豆瓣",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            DataCard(
              logo: Row(
                children: [
                  Image.network(
                    'https://cdn.sspai.com/ui/logo/logo_sspai_icon.png',
                    height: 25,
                    width: 25,
                  ),
                  Text(
                    '\r少数派',
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
              listname: '热门文章',
              title: '少数派',
              data: _dataController.sspaiData,
            ),
            DataCard(
              logo: Image.network(
                'https://res.smzdm.com/resources/public/img/pc_global/logo.png',
                width: 100,
                height: 50,
              ),
              listname: '好文原创榜',
              title: '什么值得买',
              data: _dataController.zhidemaiData,
            ),
            DataCard(
              logo: Row(
                children: [
                  Image.network(
                    'https://avatar.52pojie.cn/images/noavatar_middle.gif',
                    height: 25,
                    width: 25,
                  ),
                  Text(
                    '\r吾爱破解',
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
              listname: '今日热帖',
              title: '吾爱破解',
              data: _dataController.pojieData,
            ),
            DataCard(
              logo: Row(
                children: [
                  Image.network(
                    'https://w1.hoopchina.com.cn/channel/website/static/images/basketball-nba-logo.png',
                    height: 25,
                    width: 25,
                    color: Colors.red,
                  ),
                  Text(
                    '\r虎扑',
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
              listname: '步行街热帖',
              title: '虎扑',
              data: _dataController.hupuData,
            ),
            DataCard(
              logo: Row(
                children: [
                  Image.network(
                    'https://img3.doubanio.com/favicon.ico',
                    height: 25,
                    width: 25,
                  ),
                  Text(
                    '\r豆瓣',
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
              listname: '24小时话题',
              title: '豆瓣',
              data: _dataController.doubanData,
            ),
          ],
        ),
      ),
    );
  }
}
