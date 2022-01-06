import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DataController.dart';
import 'newpage.dart';

class DataCard extends StatelessWidget {
  Widget logo;
  String listname;
  String title;
  List data;

  DataCard({this.logo,this.listname,this.title,this.data});

  List zhidemadata = [
    '好文原创榜',//rank_type=haowen&rank_id=yc
    '好价品类榜',//rank_type=pinlei&rank_id=11
    '好价电商榜',//rank_type=dianshang&rank_id=26
    '海淘Top榜',//rank_type=haitao&rank_id=39
    '好文资讯榜',//rank_type=haowen&rank_id=zx
    '新晋好物榜',//rank_type=haowu&rank_id=hwall
    '消费众测榜'//rank_type=haowu&rank_id=zc
  ];

  link(int index){
    if(title == '少数派'){
      return 'https://sspai.com/post/${data[index]["id"]}';
    }else if(title == '什么值得买'){
      return data[index]["article_url"];
    }else {
      return data[index].link;
    }
  }

  text(int index){
    if(title == '少数派'){
      return Text('${data[index]["title"]}');
    }else if(title == '什么值得买'){
      return Text('${data[index]["article_title"]}');
    }else {
      return Text('${data[index].title}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
        height: 600,
        width: 350,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.0, 10.0), //阴影y轴偏移量
              blurRadius: 10, //阴影模糊程度
              color: Color.fromRGBO(52, 52, 52, 0.15), //阴影颜色
            ),
          ],
        ),
        child: Column(
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
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          '取消',
                                          style: TextStyle(
                                              fontSize:
                                              16,
                                              color: Colors
                                                  .grey),
                                        )),
                                    Text(
                                      '选择榜单',
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: Colors
                                              .redAccent),
                                    ),
                                    FlatButton(
                                        onPressed: ()  {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          '确定',
                                          style: TextStyle(
                                              fontSize:
                                              16,
                                              color: Colors
                                                  .blueAccent),
                                        )),
                                  ],
                                ),
                                Expanded(child: ListWheelScrollView(
                                  controller:
                                  FixedExtentScrollController(initialItem: 0),
                                  itemExtent: 40,
                                  physics: FixedExtentScrollPhysics(
                                    parent: BouncingScrollPhysics(),
                                  ),
                                  useMagnifier: true,
                                  magnification: 1.5,
                                  children: zhidemadata.map((item) {
                                    return Container(
                                      height: 60,
                                      alignment: Alignment.center,
                                      child: Text(item),
                                    );
                                  }).toList(),
                                  onSelectedItemChanged: (index) {
                                    // print(index);
                                  },
                                ))
                              ],
                            ),
                          );
                        });
                  },
                  child: Text(
                    listname,
                    style: TextStyle(fontSize: 16, color: Colors.redAccent),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Expanded(child: Obx(() {
              return ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                              NewPage(
                                title: title,
                                link: link(index),
                              ),
                              transition: Transition.noTransition);
                        },
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 2),
                                  child: index<9?Text('  ${index + 1}.'):Text('${index + 1}.'),
                                ),
                                SizedBox(width: 10,),
                                Expanded(child: text(index))
                              ],
                            ),
                            SizedBox(height: 10,),
                          ],
                        )
                      );
                    },
                  ));
            }))
          ],
        ),
      ),
    );
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
