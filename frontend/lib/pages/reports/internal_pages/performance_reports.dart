import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';

class PerformanceReport extends StatelessWidget {
  const PerformanceReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: HtmlWidget(
          '<iframe width="1366" height="900" src="https://lookerstudio.google.com/embed/reporting/1940f519-6296-42fc-be87-38b1e426e401/page/PmavD" frameborder="0" style="border:0" allowfullscreen sandbox="allow-storage-access-by-user-activation allow-scripts allow-same-origin allow-popups allow-popups-to-escape-sandbox"></iframe>',
          factoryBuilder: () => MyWidgetFactory(),
        ),
      ),
    );
  }
}

class MyWidgetFactory extends WidgetFactory with WebViewFactory {}
