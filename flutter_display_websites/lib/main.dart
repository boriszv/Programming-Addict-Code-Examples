import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

const exampleHtml = '''
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>

<script type="text/javascript">
  function myFunction() {
    FlutterApp.postMessage('test')
  }
</script>

<body>
  <button style="margin-top: 60px" onclick="myFunction()">Click me</button>
</body>
</html>
''';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://www.youtube.com/channel/UCy4TEe4CGipnHotkBztYvng',
      javascriptMode: JavascriptMode.unrestricted,
      // onWebViewCreated: (WebViewController webViewController) async {
      //   _controller.complete(webViewController);

      //   final String contentBase64 =
      //       base64Encode(const Utf8Encoder().convert(exampleHtml));
      //   await webViewController.loadUrl('data:text/html;base64,$contentBase64');
      // },
      onProgress: (int progress) {
        print("WebView is loading (progress : $progress%)");
      },
      javascriptChannels: <JavascriptChannel>{
        JavascriptChannel(
            name: 'FlutterApp',
            onMessageReceived: (JavascriptMessage message) {
              print('Javascript called!');
            })
      },
      navigationDelegate: (NavigationRequest request) {
        // if (request.url.startsWith('https://www.youtube.com/')) {
        //   print('blocking navigation to $request}');
        //   return NavigationDecision.prevent;
        // }
        print('allowing navigation to $request');
        return NavigationDecision.navigate;
      },
      onPageStarted: (String url) {
        print('Page started loading: $url');
      },
      onPageFinished: (String url) {
        print('Page finished loading: $url');
      },
      userAgent:
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36',
      gestureNavigationEnabled: true,
    );
  }
}
