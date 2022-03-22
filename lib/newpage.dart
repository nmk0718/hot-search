import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewPage extends StatefulWidget {
  String website;
  String subject;
  String link;
  bool collection;

  NewPage({this.website, this.subject, this.link,this.collection});

  @override
  NewPageState createState() => NewPageState(
      website: this.website, subject: this.subject, link: this.link,collection:this.collection);
}

class NewPageState extends State<NewPage> {
  String website;
  String subject;
  String link;
  bool collection;

  NewPageState({this.website, this.subject, this.link,this.collection});


  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text(
          website,
        ),
        actions: [
          IconButton(
              icon: Icon(
                collection == false ? Icons.star_border : Icons.star,
                color: Colors.yellow[300],
              ),
              onPressed: () async {
                if (collection == false) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  List<String> CollectionList = [];
                  if (prefs.getStringList('1') != null) {
                    CollectionList = prefs.getStringList('1');
                  } else {
                    CollectionList = [];
                  }
                  CollectionList.add(JsonEncoder().convert({
                    "website": website,
                    "subject": subject,
                    "link": link,
                  }).toString());
                  prefs.setStringList('1', CollectionList);
                  setState(() {
                    collection = true;
                  });
                } else {
                  print('已打卡');
                }
              }),
        ],
        iconTheme: IconThemeData(),
      ),
      body: Stack(
        children: [
          WebView(
            //要显示的url
            initialUrl: link,
            //JS执行模式 默认是不调用
            javascriptMode: JavascriptMode.unrestricted,
            //WebView创建完成时调用
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            //拦截请求
            navigationDelegate: (NavigationRequest request) {
              //对于需要拦截的操作 做判断
              if(request.url.startsWith("zhihu://")){
                return NavigationDecision.prevent;
              }
              //不需要拦截的操作
              setState(() {
                isLoading = true;
              });
              return NavigationDecision.navigate;
            },
            //页面加载完成
            onPageFinished: (String url) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(color: Color(0xFFFE1483),),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
