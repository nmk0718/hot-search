import 'package:flutter/material.dart';

class FontSize extends StatefulWidget {
  FontSizeState createState() => FontSizeState();
}

class FontSizeState extends State<FontSize> {
  double value = 1.0;
  String txt = '默认';
  TextStyle txtsize = TextStyle(fontSize: 14);

  @override
  Widget build(BuildContext context) {
    Color nowcolor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        iconTheme: IconThemeData(),
        title: Text("字体大小"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
                width: double.infinity,
                child: Text(
                  '示例文本',
                  style: TextStyle(fontSize: 26),
                )),
            SizedBox(
              height: 20,
            ),
            Expanded(child: Text(
                'HotSearch是一个聚合各大网站热搜的App.\n\n这是一个信息泛滥的时代,获取信息十分方便,信息的爆炸性增长也带来了内容质量参差不齐、虚假新闻泛滥等负面问题.\n\n通过各网站聚合,去了解热点和有用的信息,通过各平台的观点和不同,形成自己独特的判断和思维,不盲目相信单一信息渠道获取的信息.',style: txtsize),),
            Text(txt),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'A',
                  style: TextStyle(fontSize: 20),
                ),
                Expanded(child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    //已拖动的颜色
                      activeTrackColor:  nowcolor == Color(0xfffafafa) ?Colors.blueAccent:Colors.white,
                      //未拖动的颜色
                      inactiveTrackColor: nowcolor == Color(0xfffafafa) ?Colors.grey[300]:Colors.grey[500],

                      //滑块中心的颜色
                      thumbColor: nowcolor == Color(0xfffafafa) ?Colors.blueAccent:Colors.white,
                      //滑块边缘的颜色
                      overlayColor: Colors.transparent,

                      //divisions对进度线分割后，断续线中间间隔的颜色
                      inactiveTickMarkColor: nowcolor == Color(0xfffafafa) ?Colors.black:Colors.white,
                      tickMarkShape:
                      RoundSliderTickMarkShape(tickMarkRadius: 3.0)),
                  child: Slider(
                    value: value,
                    // label: '$value',
                    min: 0.0,
                    max: 3.0,
                    divisions: 3,
                    onChanged: (val) {
                      if (val == 0.0) {
                        txt = '小';
                        txtsize = TextStyle(fontSize: 12);
                      }
                      if (val == 1.0) {
                        txt = '默认';
                        txtsize = TextStyle(fontSize: 14);
                      }
                      if (val == 2.0) {
                        txt = '大';
                        txtsize = TextStyle(fontSize: 16);
                      }
                      if (val == 3.0) {
                        txt = '最大';
                        txtsize = TextStyle(fontSize: 18);
                      }
                      setState(() {
                        value = val.floorToDouble(); //转化成double
                      });
                    },
                  ),
                ),),
                Text(
                  'A',
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              child: Text(
                '缩小或放大屏幕上的文字',
                textAlign: TextAlign.left,
              ),
            )
          ],
        ),
      ),
    );
  }
}
