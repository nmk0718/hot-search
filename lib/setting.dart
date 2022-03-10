import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hot_search/Collection.dart';
import 'package:hot_search/changestyle.dart';
import 'changehotsearch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/CollectionData.dart';

class Setting extends StatefulWidget {
  SettingState createState() => SettingState();
}

class SettingState extends State<Setting> {
  List data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Color(0xFFFE1483), //修改颜色
        ),
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
          Get.back(result: 'success');
        }),
        title: Text(
          '设置',
          style: TextStyle(color: Color(0xFFFE1483)),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          ListView(
            shrinkWrap: true,
            children: ListTile.divideTiles(context: context, tiles: [
              ListTile(
                leading: Icon(
                  Icons.auto_awesome,
                  color: Colors.yellow[500],
                ),
                title: Text('收藏'),
                onTap: () async {
                  data = [];
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  if (prefs.getStringList('1') != null) {
                    List<String> localcollection = prefs.getStringList('1');
                    for (int i = 0; i < localcollection.length; i++) {
                      CollectionData collectiondatas = CollectionData.fromJson(
                          json.decode(localcollection[i]));
                      setState(() {
                        data.add(collectiondatas);
                      });
                    }
                  }
                  Get.to(Collection(data: data),
                      transition: Transition.noTransition);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.whatshot,
                  color: Color(0xFFFE1483),
                ),
                title: Text('更改热搜'),
                onTap: () {
                  Get.to(ChangeHotSearch(),
                      transition: Transition.noTransition);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.category,
                  color: Colors.lightBlueAccent,
                ),
                title: Text('显示样式'),
                //更改卡片模式为直接显示
                onTap: () {
                  Get.to(ChangeSytle(), transition: Transition.noTransition);
                },
              ),
            ]).toList(),
          )
        ],
      ),
    );
  }
}
