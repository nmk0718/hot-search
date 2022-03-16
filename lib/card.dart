import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DataController.dart';
import 'model/CollectionData.dart';
import 'model/websitedata.dart';
import 'newpage.dart';

class DataCard extends StatefulWidget {
  Widget logo;
  List listname;
  int model;

  DataCard({this.logo, this.listname, this.model});

  DataCardState createState() => DataCardState(
      logo: this.logo, listname: this.listname, model: this.model);
}

class DataCardState extends State<DataCard> {
  Widget logo;
  List listname;
  int model;

  DataCardState({this.logo, this.listname, this.model});

  int selectedmenuindex = 0;

  DataController _dataController = Get.put(DataController());

  link(int index, data, website) {
    if (website == '少数派') {
      return 'https://sspai.com/post/${data[index]["id"]}';
    } else if (website == '什么值得买') {
      return data[index]["article_url"];
    } else if (website == '微博') {
      return 'https://m.weibo.cn/search?containerid=100103type%3D1%26q%3D%23${data[index]["note"]}%23';
    } else if (website == '爱范儿') {
      return data[index]["post_url"];
    }
  }

  text(int index, data, website) {
    if (website == '少数派') {
      return data[index]["title"];
    } else if (website == '什么值得买') {
      return data[index]['article_title'];
    } else if (website == '微博') {
      if (data[index]["note"] != null) {
        return data[index]["note"];
      } else if (data[index]["topic"] != null) {
        return data[index]["topic"];
      }
    }else if (website == '爱范儿') {
        return data[index].postTitle;
    }
  }

  content(context, data) {
    String website =
        _dataController.websiteList[_dataController.tabindex.value]['website'];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            logo,
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return Container(
                        height: 250,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      '取消',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    )),
                                Text(
                                  '选择榜单',
                                  style: TextStyle(
                                      fontSize: 19, color: Colors.redAccent),
                                ),
                                FlatButton(
                                    onPressed: () {
                                      websitedata selectwebsite = websitedata
                                          .fromJson(_dataController.websiteList[
                                              _dataController.tabindex.value]);
                                      _dataController.updateData(selectwebsite
                                          .menu[selectedmenuindex].menuUrl);
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      '确定',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blueAccent),
                                    )),
                              ],
                            ),
                            Expanded(
                                child: ListWheelScrollView(
                              controller:
                                  FixedExtentScrollController(initialItem: 0),
                              itemExtent: 40,
                              physics: FixedExtentScrollPhysics(
                                parent: BouncingScrollPhysics(),
                              ),
                              useMagnifier: true,
                              magnification: 1.5,
                              children: listname.map((item) {
                                return Container(
                                  height: 60,
                                  alignment: Alignment.center,
                                  child: Text(item.menuName),
                                );
                              }).toList(),
                              onSelectedItemChanged: (index) {
                                // print(index);
                                selectedmenuindex = index;
                                setState(() {});
                              },
                            ))
                          ],
                        ),
                      );
                    });
              },
              child: Text(
                listname[selectedmenuindex].menuName,
                style: TextStyle(fontSize: 16, color: Colors.redAccent),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        data != null
            ? Expanded(
                child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              if (prefs.getStringList('1') != null) {
                                bool collection = false;
                                for (var item in prefs.getStringList('1')) {
                                  CollectionData collectiondatas =
                                      CollectionData.fromJson(
                                          json.decode(item));
                                  if (collectiondatas.link ==
                                      link(index, data, website)) {
                                    collection = true;
                                  }
                                }
                                Get.to(
                                    NewPage(
                                      website: website,
                                      link: link(index, data, website),
                                      subject:
                                          text(index, data, website).toString(),
                                      collection: collection,
                                    ),
                                    transition: Transition.noTransition);
                              } else {
                                Get.to(
                                    NewPage(
                                      website: website,
                                      link: link(index, data, website),
                                      subject:
                                          text(index, data, website).toString(),
                                      collection: false,
                                    ),
                                    transition: Transition.noTransition);
                              }
                            },
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(top: 2),
                                      child: index < 9
                                          ? Text('  ${index + 1}.')
                                          : Text('${index + 1}.'),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child:
                                            Text(text(index, data, website))),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ));
                      },
                    )))
            : Container()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //通过公共的状态来显示卡片模式还是直接显示
    return Obx(() {
      List data = _dataController.hotsearchData;
      return Stack(
        children: [
          model == 0
              ? Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.0, 10.0), //阴影y轴偏移量
                          blurRadius: 15, //阴影模糊程度
                          color: Color.fromRGBO(52, 52, 52, 0.15), //阴影颜色
                        ),
                      ],
                    ),
                    child: content(context, data),
                  ),
                )
              : Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  color: Colors.white,
                  child: content(context, data),
                ),
          data == null || data.isEmpty
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(color: Color(0xFFFE1483),),
                  ),
                )
              : Container()
        ],
      );
    });
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    if (Platform.isAndroid || Platform.isFuchsia) {
      return child;
    } else {
      return super.buildViewportChrome(context, child, axisDirection);
    }
  }
}
