import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webview extends StatefulWidget {
  const Webview({super.key, required this.uri});
  final String uri;

  @override
  State<Webview> createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  WebViewController? controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController();
    Uri uri = Uri.parse(widget.uri);
    controller!.loadRequest(uri);
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller!);
  }
}
