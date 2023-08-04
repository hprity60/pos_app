import 'package:assignment_app/core/routes/app_router.dart';
import 'package:assignment_app/features/sign_in/presentation/pages/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/network/dio_client.dart';
import 'core/network/network_info.dart';
import 'features/employee/data/datasources/local_data_source/get_employee_local_data_source_impl.dart';
import 'features/employee/data/datasources/remote_data_source/get_employee_remote_data_source_impl.dart';
import 'features/employee/data/repositories/get_employee_repository_impl.dart';
import 'features/employee/presentation/bloc/employee_list_bloc.dart';

class App extends StatelessWidget {
  App({required this.appRouter, super.key});

  AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeListBloc(
          getEmployeeListRepository: GetEmployeeListRepositoryImpl(
              getEmployeeRemoteDataSource:
                  GetEmployeeRemoteDataSourceImpl(dio: DioProvider()),
              getEmployeeLocalDataSource: GetEmployeeLocalDataSourceImpl(
                  box: Hive.box('cacheEmployees')),
              networkInfo: NetworkInfoImpl(InternetConnectionChecker()))),
      child: MaterialApp(
        initialRoute: SignInScreen.id,
        onGenerateRoute: appRouter.onGenerateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
