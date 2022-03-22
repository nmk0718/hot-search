import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          centerTitle: true,
          iconTheme: IconThemeData(),
          title: Text('关于'),
        ),
        body: Column(
          children: [
            SizedBox(height: 50,),
            Center(
              child: Image.network('https://nmk0718.github.io/image/HotSearch/HotSearch.png',height: 80,width: 80,),
            ),
            SizedBox(height: 10,),
            Text('HotSearch',style:TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
            SizedBox(height: 10,),
            Text('1.0.0',style:TextStyle(fontSize: 16)),
            SizedBox(height: 40,),
            Container(
              width: 300,
              child: Text('HotSearch是一个聚合各大网站热搜的App.\n\n这是一个信息泛滥的时代,获取信息十分方便,信息的爆炸性增长也带来了内容质量参差不齐、虚假新闻泛滥等负面问题.\n\n通过各网站聚合,去了解热点和有用的信息,通过各平台的观点和不同,形成自己独特的判断和思维,不盲目相信单一信息渠道获取的信息.'),
            ),
          ],
        ));
  }
}
