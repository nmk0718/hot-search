import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'newpage.dart';

class Collection extends StatelessWidget {
  List data;

  Collection({this.data});

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
          '收藏',
          style: TextStyle(color: Color(0xFFFE1483)),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: Column(children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Get.to(
                        NewPage(
                          website: data[index].website,
                          link: data[index].link,
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
                            child: index < 9
                                ? Text('  ${index + 1}.')
                                : Text('${index + 1}.'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Text(data[index].subject))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ));
            },
          ),
        ]),
      ),
    );
  }
}
