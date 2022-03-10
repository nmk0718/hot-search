import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hot_search/model/websitedata.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DataController.dart';

class InsterWebsite extends StatefulWidget {
  InsterWebsiteState createState() => InsterWebsiteState();
}

class InsterWebsiteState extends State<InsterWebsite> {
  DataController _dataController = Get.put(DataController());
  int itemindex;
  List insterdata = [];

  Widget logo(website) {
    if (website.website == '什么值得买') {
      return Row(
        children: [
          Image.network(
            'https://res.smzdm.com/resources/public/img/pc_global/logo.png',
            height: 50,
          )
        ],
      );
    } else if (website.website == '微博') {
      return Row(
        children: [
          Image.network(
            website.icon,
            height: 50,
            width: 50,
          ),
          Text(
            '\r${website.website}',
            style: TextStyle(fontSize: 18),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Image.network(
            website.icon,
            height: 45,
            width: 45,
            color: website.website == '虎扑' ? Colors.red : null,
          ),
          Text(
            '\r\r${website.website}',
            style: TextStyle(fontSize: 18),
          ),
        ],
      );
    }
  }

  getinsterdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> deletedata = prefs.getStringList('deleteData');
    setState(() {
      insterdata.addAll(deletedata);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getinsterdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Color(0xFFFE1483), //修改颜色
        ),
        title: Text(
          '新增热搜',
          style: TextStyle(color: Color(0xFFFE1483)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.done, color: Color(0xFFFE1483)),
            onPressed: () async {
              //把当前选中的数据先增加到websitelist
              var selecteddata = json.decode(insterdata[itemindex]);
              _dataController.additem(selecteddata);

              //把当前websitelist的数据存储到本地
              SharedPreferences prefs = await SharedPreferences.getInstance();
              var result = json.encode(_dataController.websiteList.value);
              prefs.setString('website',result);

              //移除本地缓存中选中的数据项
              List<String> deletedata = prefs.getStringList('deleteData');
              deletedata.remove(insterdata[itemindex]);
              prefs.setStringList('deleteData', deletedata);
              setState(() {
                insterdata.remove(insterdata[itemindex]);
              });
            },
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: insterdata.length,
          itemBuilder: (context, index) {
            var result = json.decode(insterdata[index]);
            websitedata websites = websitedata.fromJson(result);
            return GestureDetector(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                    decoration: new BoxDecoration(
                      color: itemindex == index ? Colors.yellow : Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.0, 10.0), //阴影y轴偏移量
                          blurRadius: 15, //阴影模糊程度
                          color: Color.fromRGBO(52, 52, 52, 0.1), //阴影颜色
                        ),
                      ],
                    ),
                    child: logo(websites),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
              onTap: () {
                setState(() {
                  itemindex = index;
                });
              },
            );
          },
        ),
      ),
    );
  }
}
