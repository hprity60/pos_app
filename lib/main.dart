import 'package:assignment_app/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('cacheEmployees');
  runApp(App(
    appRouter: AppRouter(),
  ));
}
