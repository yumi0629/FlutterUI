import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';

/// https://juejin.im/post/5ca1da31e51d4509ea3d0540
class WebViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WebViewPageState();
  }
}

class WebViewPageState extends State<WebViewPage> {
  JavascriptChannel _alertJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toast',
        onMessageReceived: (JavascriptMessage message) {
          showToast(message.message);
        });
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter WebView example'),
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: 'http://bin.amazeui.org/fiqabe',
//          initialUrl: '',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
//            _controller = webViewController;
            _controller.complete(webViewController);
//            _loadHtmlFromAssets(webViewController);
          },
          javascriptChannels: <JavascriptChannel>[
            _alertJavascriptChannel(context),
          ].toSet(),
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('js://webview')) {
              showToast('JS call Flutter By navigationDelegate');
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            } else if (request.url.startsWith('xxxxxx://')) {
              _openApp(request.url);
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
        );
      }),
      floatingActionButton: jsButton(),
    );
  }

  /// load local html.
  _loadHtmlFromAssets(controller) async {
    String fileText = await rootBundle.loadString('lib/assets/test.html');
    controller.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  Widget jsButton() {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          if (controller.hasData) {
            return FloatingActionButton(
              onPressed: () async {
                _controller.future.then((controller) {
                  controller
                      .evaluateJavascript('callJS("visible")')
                      .then((result) {});
                });
              },
              child: Text('call JS'),
            );
          }
          return Container();
        });
  }

  void _openApp(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
