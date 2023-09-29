import 'package:uanguanguang/constant/route_constants.dart';
import 'package:uanguanguang/pages/AddExpenditurePage.dart';
import 'package:uanguanguang/pages/AddIncomePage.dart';
import 'package:uanguanguang/pages/DetailCashFlowPage.dart';
import 'package:uanguanguang/pages/HomePage.dart';
import 'package:uanguanguang/pages/LoginPage.dart';
import 'package:uanguanguang/pages/SettingsPage.dart';
import 'package:uanguanguang/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ], child: const MyApp()));
}

final routes = {
  loginRoute: (BuildContext context) => LoginPage(),
  homeRoute: (BuildContext context) => HomePage(),
  settingsRoute: (BuildContext context) => SettingsPage(),
  addExpenseRoute: (BuildContext context) => AddExpenditurePage(),
  addIncomeRoute: (BuildContext context) => AddIncomePage(),
  detailCashFlowRoute: (BuildContext context) => DetailCashFlowPage(),
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Duitku App",
      theme: ThemeData(primarySwatch: Colors.indigo),
      routes: routes,
    );
  }
}
