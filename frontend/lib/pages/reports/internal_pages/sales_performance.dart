import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
import 'package:get_storage/get_storage.dart';
import 'package:terrahub/shared/routes.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

final storage = GetStorage();

class SalesPerformanceReport extends StatelessWidget {
  SalesPerformanceReport({super.key});
  final ExportDelegate exportDelegate = ExportDelegate();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ExportFrame(
          frameId: 'report',
          exportDelegate: exportDelegate,
          child: SizedBox(
            child: HtmlWidget(
              '<iframe width="1366" height="900" src="https://lookerstudio.google.com/embed/reporting/73f870ec-be9c-4e2f-8f51-94a6756ba9d7/page/a9YxD" frameborder="0" style="border:0" allowfullscreen sandbox="allow-storage-access-by-user-activation allow-scripts allow-same-origin allow-popups allow-popups-to-escape-sandbox"></iframe>',
              factoryBuilder: () => MyWidgetFactory(),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          html.window.print();
          Navigator.pushNamed(context, Routes.minimumdemandreports);
        },
        child: const Icon(Icons.print),
      ),
    );
  }
}

class MyWidgetFactory extends WidgetFactory with WebViewFactory {}
