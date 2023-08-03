import 'package:assignment_app/features/employee/presentation/pages/employee_list_screen.dart';
import 'package:assignment_app/features/home/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';

import '../../features/sign_in/presentation/pages/sign_in_screen.dart';
import '../arg_model/dashboard_arg_model.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SignInScreen.id:
        //  final args = routeSettings.arguments as ArgModel;
        return MaterialPageRoute(builder: (_) => SignInScreen());

      case HomeScreen.id:
        final args = routeSettings.arguments as DashboardArgModel;
        return MaterialPageRoute(
            builder: (_) => HomeScreen(
                  userName: args.userName,
                  email: args.email,
                  phone: args.phone,
                  designation: args.designation,
                  joinDate: args.joinDate,
                ));

      case EmployeeListScreen.id:
        //  final args = routeSettings.arguments as ArgModel;
        return MaterialPageRoute(builder: (_) => EmployeeListScreen());

      default:
        return null;
    }
  }
}
