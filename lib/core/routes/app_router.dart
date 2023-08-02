import 'package:flutter/material.dart';

import '../../features/sign_in/presentation/pages/sign_in_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SignInScreen.id:
        //  final args = routeSettings.arguments as ArgModel;
        return MaterialPageRoute(builder: (_) =>  SignInScreen());

      default:
        return null;
    }
  }
}
