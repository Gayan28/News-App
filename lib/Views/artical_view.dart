// ignore_for_file: library_private_types_in_public_api
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String blogUrl;
  const ArticleView({super.key, required this.blogUrl});
  
  @override
 _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {

  final Completer<WebViewController> completer = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            Text('Daily'),
            Text('News',
            style: TextStyle(
              color: Colors.blue,
            ),
            ),
          ]
          ),
          actions:<Widget> [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.save))
          ],
          centerTitle: true,
          elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl:widget.blogUrl,
          onWebViewCreated:((WebViewController webViewController){
            completer.complete(webViewController);

          }),
        ),
      )
    );
  }
}