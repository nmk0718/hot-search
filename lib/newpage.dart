import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewPage extends StatelessWidget {
  String title;
  String link;

  NewPage({this.title,this.link});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text(title,style: TextStyle(color: Color(0xFFFE1483)),),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color(0xFFFE1483),
        ),
      ),
      body: WebView(
        initialUrl: link,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
