import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DataController.dart';
import 'model/CollectionData.dart';
import 'model/websitedata.dart';
import 'newpage.dart';

class DataCard extends StatefulWidget {
  DataCardState createState() => DataCardState();
}

class DataCardState extends State<DataCard> {
  int selectedmenuindex = 0;

  DataController _dataController = Get.put(DataController());


  Widget logo(website) {
    if (website.website == '什么值得买') {
      return Image.network(
        'https://res.smzdm.com/resources/public/img/pc_global/logo.png',
        width: 100,
        height: 30,
      );
    }
    if (website.website == '微博') {
      return Row(
        children: [
          Image.network(
            website.icon,
            height: 35,
            width: 35,
          ),
          Text(
            '\r${website.website}',
            style: TextStyle(fontSize: 17),
          ),
        ],
      );
    }
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

  content(context, data) {
    Color nowcolor = Theme.of(context).scaffoldBackgroundColor;
    var selecteddata =
        _dataController.websiteList[_dataController.tabindex.value];
    websitedata selectwebsite = websitedata.fromJson(selecteddata);
    String website = selecteddata['website'];
    var menu = selectwebsite.menu;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            logo(selectwebsite),
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
                              children: menu.map((item) {
                                return Container(
                                  height: 60,
                                  alignment: Alignment.center,
                                  child: Text(item.menuName),
                                );
                              }).toList(),
                              onSelectedItemChanged: (index) {
                                // (index);
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
                menu[selectedmenuindex].menuName,
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
                                      data[index]['link']) {
                                    collection = true;
                                  }
                                }
                                Get.to(
                                    NewPage(
                                      website: website,
                                      link: data[index]['link'],
                                      subject: data[index]['title'],
                                      collection: collection,
                                    ),
                                    transition: Transition.noTransition);
                              } else {
                                Get.to(
                                    NewPage(
                                      website: website,
                                      link: data[index]['link'],
                                      subject: data[index]['title'],
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
                                      width: 20,
                                      child: Text(
                                        '${index + 1}',
                                        style: TextStyle(height: 1.5,color: nowcolor == Color(0xfffafafa)?Colors.black:Colors.grey[500]),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        data[index]['title'],
                                        style: TextStyle(height: 1.5,color: nowcolor == Color(0xfffafafa)?Colors.black:Colors.grey[500]),
                                      ),
                                    ),
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
    Color nowcolor = Theme.of(context).scaffoldBackgroundColor;
    //通过公共的状态来显示卡片模式还是直接显示
    return Obx(() {
      List data = _dataController.hotsearchData;
      return Stack(
        children: [
          _dataController.model.value == 0
              ? Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                    decoration: new BoxDecoration(
                      color: nowcolor == Color(0xfffafafa)?Colors.white:Colors.black26,
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
                  color:  nowcolor == Color(0xfffafafa)?Colors.white:Colors.black26,
                  child: content(context, data),
                ),
          data == null || data.isEmpty
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFFE1483),
                    ),
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
