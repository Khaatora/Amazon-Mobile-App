import 'package:amazon_e_commerce_clone/features/admin/posts/view/components/add_product_screen.dart';
import 'package:amazon_e_commerce_clone/features/auth/views/auth_screen.dart';
import 'package:flutter/material.dart';

import '../features/home/views/admin_bottom_nav_bar_layout.dart';
import '../features/home/views/user_bottom_nar_bar_layout.dart';

class AppRoutes{
  
  //authentication screen
  static const String authScreen ='/auth';
  static const String userScreen ='/user_home';
  static const String adminScreen ='/admin_home';
  static const String addProductsScreen ='/add_products';

  static Route<dynamic>? generateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case authScreen:
        return MaterialPageRoute(settings: routeSettings,builder: (context) => const AuthScreen(),);
      case userScreen:
        return MaterialPageRoute(settings: routeSettings,builder: (context) => const UserBottomNavBarLayout(),);
      case adminScreen:
        return MaterialPageRoute(settings: routeSettings,builder: (context) => const AdminBottomNavBarLayout(),);
      case addProductsScreen:
        return MaterialPageRoute(settings: routeSettings,builder: (context) => const AddProductScreen(),);
      default:
        return null;
    }
  }
}