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
          style: TextStyle(color: Color(0xFFFE1483)),
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
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color(0xFFFE1483),
        ),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: link,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            navigationDelegate: (NavigationRequest request) {
              var url = request.url;
              setState(() {
                isLoading = true;
              });
              return NavigationDecision.navigate;
            },
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
