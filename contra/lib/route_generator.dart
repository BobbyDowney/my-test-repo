import 'package:flutter/material.dart';

import 'profile.dart';
import 'signIn.dart';
import 'userSearch.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/signin':
        return PageRouteBuilder(pageBuilder: (_, __, ___) => SignInScreen());
      case '/usersearch':
        return PageRouteBuilder(pageBuilder: (_, __, ___)=> UserSearchScreen());
      case '/profile':
        return PageRouteBuilder(pageBuilder: (_, __, ___) => ProfileScreen());
      default:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => SignInScreen());
    }
  }
}