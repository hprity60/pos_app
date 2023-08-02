import 'package:assignment_app/features/home/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';

import '../../features/sign_in/presentation/pages/sign_in_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SignInScreen.id:
        //  final args = routeSettings.arguments as ArgModel;
        return MaterialPageRoute(builder: (_) =>  SignInScreen());

        case HomeScreen.id:
        //  final args = routeSettings.arguments as ArgModel;
        return MaterialPageRoute(builder: (_) =>  HomeScreen());

      default:
        return null;
    }
  }
}
