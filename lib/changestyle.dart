import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'DataController.dart';

class ChangeSytle extends StatefulWidget {
  ChangeSytleState createState() => ChangeSytleState();
}

class ChangeSytleState extends State<ChangeSytle> {
  DataController _dataController = Get.put(DataController());

  int status = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          centerTitle: true,
          iconTheme: IconThemeData(),
          title: Text(
            '视图样式',
          ),
        ),
        body: Obx(() {
          int modle =_dataController.model.value;
          return Column(
            children: [
              modle== 0
                  ? Padding(padding: EdgeInsets.only(top: 20),child: Container(
                padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                height: 550,
                width: 300,
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
                child: Text('我是示例'),
              ),)
                  : Container(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                      height: 570,
                      width: double.infinity,
                      color: Colors.white,
                      child: Text('我是示例'),
                    ),
              RadioListTile(
                  value: 0,
                  groupValue: modle,
                  title: Text('卡片模式'),
                  selected: modle == 0,
                  onChanged: (value) {
                    _dataController.updatemodel(value);
                  }),
              RadioListTile(
                  value: 1,
                  groupValue: modle,
                  title: Text('直观模式'),
                  selected: modle == 1,
                  onChanged: (value) {
                    _dataController.updatemodel(value);
                  }),
            ],
          );
        }));
  }
}
