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
        iconTheme: IconThemeData(),
        title: Text(
          '收藏',
        ),
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
                            width: 20,
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(height: 1.5),
                            ),
                          ),
                          Expanded(
                            child: Text(
                                data[index].subject,
                              style: TextStyle(height: 1.5),
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
          ),
        ]),
      ),
    );
  }
}
