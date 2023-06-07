import 'package:amazon_e_commerce_clone/features/auth/views/auth_screen.dart';
import 'package:amazon_e_commerce_clone/features/home/views/home_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes{
  
  //authentication screen
  static const String authScreen ='/auth_screen';
  static const String homeScreen ='/home_screen';

  static Route<dynamic> generateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case authScreen:
        return MaterialPageRoute(settings: routeSettings,builder: (context) => const AuthScreen(),);
      case homeScreen:
        return MaterialPageRoute(settings: routeSettings,builder: (context) => const HomeScreen(),);
      default:
        return MaterialPageRoute(builder: (context) => const Scaffold(body:  Center(
          child: Text("Screen Does Not Exist!"),
        ),),);
    }
  }
}