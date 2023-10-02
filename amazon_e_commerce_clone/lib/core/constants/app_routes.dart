import 'package:amazon_e_commerce_clone/features/auth/views/auth_screen.dart';
import 'package:amazon_e_commerce_clone/features/order_details/view/order_details_screen.dart';
import 'package:amazon_e_commerce_clone/features/user/address/view/address_screen.dart';
import 'package:amazon_e_commerce_clone/features/user/home/views/components/category_screen.dart';
import 'package:amazon_e_commerce_clone/features/user/product_details/view/product_details_screen.dart';
import 'package:amazon_e_commerce_clone/features/user/search/view/search_screen.dart';
import 'package:flutter/material.dart';

import '../../features/admin/products/view/components/add_product_screen.dart';
import '../features/home/views/admin_bottom_nav_bar_layout.dart';
import '../features/home/views/user_bottom_nar_bar_layout.dart';

class AppRoutes{
  
  //authentication screen
  static const String authScreen ='/auth';
  static const String userScreen ='/user-home';
  static const String adminScreen ='/admin-home';
  static const String addProductsScreen ='/add-products';
  static const String categoryScreen ='/category-data';
  static const String searchScreen ='/search';
  static const String productDetailsScreen ='/product-details';
  static const String addressScreen ='/address';
  static const String orderDetailsScreen ='/order-details';

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
      case categoryScreen:
        return MaterialPageRoute(settings: routeSettings,builder: (context) => const CategoryScreen(),);
      case searchScreen:
        return MaterialPageRoute(settings: routeSettings,builder: (context) => const SearchScreen(),);
      case productDetailsScreen:
        return MaterialPageRoute(settings: routeSettings,builder: (context) => const ProductDetailsScreen(),);
      case addressScreen:
        return MaterialPageRoute(settings: routeSettings,builder: (context) => const AddressScreen(),);
      case orderDetailsScreen:
        return MaterialPageRoute(settings: routeSettings,builder: (context) => const OrderDetailsScreen(),);
      default:
        return null;
    }
  }
}