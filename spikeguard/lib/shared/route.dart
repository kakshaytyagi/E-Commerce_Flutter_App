import 'package:flutter/material.dart';
import 'package:spikeguard/screens/CompanyInfoScreen.dart';
import 'package:spikeguard/screens/cart_screen.dart';
import 'package:spikeguard/screens/home_screen.dart';
import 'package:spikeguard/screens/search_screen.dart';
import 'package:spikeguard/shared/globals.dart';
import 'package:spikeguard/widget/bottom_navigation.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const CatalogScreen(),
    'company_info_screen': (context) =>  CompanyInfoScreen(),
    'search_screen': (context) => SearchScreen(productData: productData),
    'cart_screen': (context) => ProductListingScreen(shoppingCart: shoppingCart),
  };

  static BottomNavBarCurvedFb1 getBottomNavigationBar() {
    return const BottomNavBarCurvedFb1();
  }
}
