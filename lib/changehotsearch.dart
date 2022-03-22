import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DataController.dart';
import 'insertwebsite.dart';
import 'model/websitedata.dart';

class ChangeHotSearch extends StatefulWidget {
  ChangeHotSearchState createState() => ChangeHotSearchState();
}

class ChangeHotSearchState extends State<ChangeHotSearch> {
  DataController _dataController = Get.put(DataController());
  Widget logo(website){

    if(website.website == '什么值得买'){
      return Row(
        children: [
          Image.network(
            'https://res.smzdm.com/resources/public/img/pc_global/logo.png',
            height: 50,
          )
        ],
      );
    }else if (website.website == '微博'){
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
    }else{
      return Row(
        children: [
          Image.network(
            website.icon,
            height: 45,
            width: 45,
            color:
            website.website ==
                '虎扑'
                ? Colors.red
                : null,
          ),
          Text(
            '\r\r${website.website}',
            style: TextStyle(fontSize: 18),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        iconTheme: IconThemeData(),
        title: Text(
          '更改热搜',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              Get.to(InsterWebsite(), transition: Transition.noTransition);
            },
          ),
        ],
      ),
      body:Obx((){
        return ReorderableListView(
          children: _dataController.websiteList
              .map(
                (s) => Dismissible(
              key: Key(s.toString()),
              child: Padding(
                padding: EdgeInsets.only(top: 10,left: 20,right: 20,bottom: 10),
                child: Container(
                  padding:
                  EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.all(Radius.circular(15.0)),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.0, 10.0), //阴影y轴偏移量
                        blurRadius: 15, //阴影模糊程度
                        color: Color.fromRGBO(52, 52, 52, 0.1), //阴影颜色
                      ),
                    ],
                  ),
                  child: logo(websitedata.fromJson(s))
                ),
              ),
              onDismissed: (direction) async {
                  _dataController.removeitem(s);
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  var result = json.encode(_dataController.websiteList.value);
                  prefs.setString('website',result);
                  if(prefs.getStringList('deleteData') !=null){
                    List<String> deletedata = prefs.getStringList('deleteData');
                    var result = json.encode(s);
                    deletedata.add(result);
                    prefs.setStringList('deleteData',deletedata);
                  }else{
                    List<String> deletedata = [];
                    var result = json.encode(s);
                    deletedata.add(result);
                    prefs.setStringList('deleteData',deletedata);
                  }
                  setState(() {
                });
              },
            ),
          )
              .toList(),
          onReorder: (int oldIndex, int newIndex) async {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              var temp = _dataController.websiteList.removeAt(oldIndex);
              _dataController.websiteList.insert(newIndex, temp);
            }
            );
            SharedPreferences prefs = await SharedPreferences.getInstance();
            var result = json.encode(_dataController.websiteList.value);
            prefs.setString('website',result);
          },
        );
      }),
    );
  }
}
