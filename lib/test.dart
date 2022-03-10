import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

class Test extends StatefulWidget{
  TestState createState()=> TestState();
}

class TestState extends State<Test> with SingleTickerProviderStateMixin{
  TabController tabController;
  String showtext;

  getdata() async {
    var response = await Dio().get('https://www.52pojie.cn/misc.php?mod=ranklist&type=thread&view=heats&orderby=today');
    var document = parse(response.data);
    setState(() {

      showtext = document.querySelector('th').text;

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this)
    ..addListener(() {
      if (tabController.index.toDouble() ==
          tabController.animation.value) {
        print(tabController.index);
      }
    });
    getdata();
  }

  @override
  Widget build(BuildContext context) {
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
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 20),
            child: TabBar(
              controller: tabController,
                indicatorColor: Color(0xFFFE1483),
                labelColor: Color(0xFFFE1483),
                unselectedLabelColor: Colors.black54,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(
                    text: 'QQ',
                  ),
                  Tab(
                    text: 'WW',
                  ),
                ]),
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children:[
           Text('1'),
           Text('2')
          ],
        ));
  }
}