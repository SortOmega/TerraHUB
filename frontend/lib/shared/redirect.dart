import 'package:flutter/material.dart';
import 'package:terrahub/models/estate_model.dart';
import 'package:terrahub/pages/Home/home_page.dart';
import 'package:terrahub/pages/estate/info_estate_page.dart';

import 'package:terrahub/pages/hub/hub_page.dart';
import 'package:terrahub/pages/hub/internal%20pages/buys_pages/buys_page.dart';
import 'package:terrahub/pages/hub/internal%20pages/buys_pages/create_buys_page.dart';
import 'package:terrahub/pages/hub/internal%20pages/estate_pages/create_estate_page.dart';
import 'package:terrahub/pages/hub/internal%20pages/estate_pages/estate_page.dart';
import 'package:terrahub/pages/hub/internal%20pages/request_pages/request_manage_page.dart';
import 'package:terrahub/pages/hub/internal%20pages/request_pages/request_page.dart';
import 'package:terrahub/pages/hub/internal%20pages/sales_pages/create_sales_page.dart';
import 'package:terrahub/pages/hub/internal%20pages/sales_pages/sales_page.dart';
import 'package:terrahub/pages/login/login_page.dart';
import 'package:terrahub/pages/reports/internal_pages/buys_reports.dart';
import 'package:terrahub/pages/reports/internal_pages/minimun_demand_reports.dart';
import 'package:terrahub/pages/reports/internal_pages/operational_evaluation.dart';
import 'package:terrahub/pages/reports/internal_pages/performance_reports.dart';
import 'package:terrahub/pages/reports/internal_pages/sales_performance.dart';
import 'package:terrahub/pages/reports/internal_pages/sales_reports.dart';
import 'package:terrahub/pages/reports/reports_page.dart';
import 'package:terrahub/shared/routes.dart';

final redirect = {
  Routes.home: (context) => const HomePage(),
  Routes.login: (context) => LoginPage(),
  Routes.hub: (context) => HubPage(),
  Routes.estates: (context) => EstatePage(),
  Routes.estateinfo: (context) => EstateInfoPage(
      estate: ModalRoute.of(context)!.settings.arguments as Estate),
  Routes.sales: (context) => SalesPage(),
  Routes.buys: (context) => BuysPage(),
  Routes.request: (context) => RequestPage(),
  Routes.requestInfo: (context) => RequestManagePage(),
  Routes.createSales: (context) => CreateSalesPage(),
  Routes.createBuys: (context) => CreateBuysPage(),
  Routes.createEstates: (context) => CreateStatePage(),
  Routes.reports: (context) => const ReportsPage(),
  Routes.salesreports: (context) => const SalesReport(),
  Routes.buysreports: (context) => const BuysReport(),
  Routes.performancereports: (context) => const PerformanceReport(),
  Routes.minimumdemandreports: (context) => MinimunDemandReport(),
  Routes.operationalevaluationreports: (context) =>
      OperationalEvaluationReport(),
  Routes.salesperformancereports: (context) => SalesPerformanceReport(),
};
