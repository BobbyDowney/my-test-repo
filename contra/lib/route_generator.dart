import 'package:flutter/material.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return PageRouteBuilder(pageBuilder: (_, __, ___) => MyHomePage(title:"Home page"));
      case '/login':
        return PageRouteBuilder(pageBuilder: (_, __, ___) => LoginScreen());
      case '/texting':
        return PageRouteBuilder(pageBuilder: (_, __, ___)=> TextScreen());
      case '/profile':
        return PageRouteBuilder(pageBuilder: (_, __, ___) => ProfileScreen());
      case '/signup':
        return PageRouteBuilder(pageBuilder: (_, __, ___) => SignupScreen());
    }
  }
}