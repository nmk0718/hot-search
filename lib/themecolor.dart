import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Themes.dart';

class ThemeColor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          centerTitle: true,
          iconTheme: IconThemeData(),
          title: Text('主题颜色'),
        ),
        body: ListView(
          shrinkWrap: true,
          children: ListTile.divideTiles(context: context, tiles: [
            ListTile(
              leading: Container(
                height: 35,
                width: 35,
                decoration: new BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
              ),
              title: Text('早苗绿'),
              onTap: () async {
                Get.changeTheme(Themes.green);
              },
            ),
            ListTile(
              leading: Container(
                height: 35,
                width: 35,
                decoration: new BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
              ),
              title: Text('咸蛋黄'),
              onTap: () {
                Get.changeTheme(Themes.yellow);
              },
            ),
            ListTile(
              leading: Container(
                height: 35,
                width: 35,
                decoration: new BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
              ),
              title: Text('高能红'),
              //更改卡片模式为直接显示
              onTap: () {
                Get.changeTheme(Themes.red);
              },
            ),
            ListTile(
              leading: Container(
                height: 35,
                width: 35,
                decoration: new BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
              ),
              title: Text('主题黑'),
              //更改卡片模式为直接显示
              onTap: () {
                Get.changeTheme(Themes.black);
              },
            ),
            ListTile(
              leading: Container(
                height: 35,
                width: 35,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
              ),
              title: Text('简洁白'),
              //更改卡片模式为直接显示
              onTap: () {
                Get.changeTheme(Themes.white);
              },
            ),
          ]).toList(),
        ));
  }
}
