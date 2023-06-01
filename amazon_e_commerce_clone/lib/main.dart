import 'package:amazon_e_commerce_clone/core/constants/app_routes.dart';
import 'package:amazon_e_commerce_clone/core/global/app_theme.dart';
import 'package:amazon_e_commerce_clone/core/services/services_locator.dart';
import 'package:flutter/material.dart';

void main() {
  ServicesLocator().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerece App',
      theme: AppTheme.light,
      initialRoute: AppRoutes.authScreen,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (routeSettings) => AppRoutes.generateRoute(routeSettings),
    );
  }
}