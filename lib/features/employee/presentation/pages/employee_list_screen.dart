import 'package:assignment_app/core/network/dio_client.dart';
import 'package:assignment_app/core/network/network_info.dart';
import 'package:assignment_app/core/values/date_formatter.dart';
import 'package:assignment_app/core/values/text_styles.dart';
import 'package:assignment_app/features/employee/data/datasources/local_data_source/get_employee_local_data_source_impl.dart';
import 'package:assignment_app/features/employee/data/models/employee_list_response_model.dart';
import 'package:assignment_app/features/employee/data/repositories/get_employee_repository_impl.dart';
import 'package:assignment_app/features/employee/presentation/bloc/employee_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../data/datasources/remote_data_source/get_employee_remote_data_source_impl.dart';
import '../../data/models/active_employee_list_response_model.dart';

class EmployeeListScreen extends StatelessWidget {
  static const id = "employee_list_screen";
  EmployeeListScreen({super.key});

  String fullName = "";
  late EmployeeResponseModel employeeList;
  ActiveEmployeeListResponseModel? activeEmployeeList;
  String activeEmployeeStatus = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeListBloc(
          getEmployeeListRepository: GetEmployeeListRepositoryImpl(
              getEmployeeRemoteDataSource:
                  GetEmployeeRemoteDataSourceImpl(dio: DioProvider()),
              getEmployeeLocalDataSource: GetEmployeeLocalDataSourceImpl(
                  box: Hive.box('cacheEmployees')),
              networkInfo: NetworkInfoImpl(InternetConnectionChecker())))
        ..add(GetEmployeeListEvent()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Employee List"),
        ),
        body: BlocBuilder<EmployeeListBloc, EmployeeListState>(
          builder: (context, state) {
            print("Current state >> $state");
            if (state is EmployeeListSuccessState) {
              employeeList = state.employeeResponseModel;
              int length = employeeList.result.length;
              return RefreshIndicator(
                onRefresh: () async {
                  //_cmd = true;
                  context.read<EmployeeListBloc>().add(
                        GetEmployeeListEvent(),
                      );
                },
                child: SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              "All Employees",
                              style: textStyleF22W700(),
                            ),
                           const Spacer(),
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                print("Selected value: $value");

                                if (value == "Out") {
                                  context.read<EmployeeListBloc>().add(
                                        GetEmployeeListEvent(),
                                      );
                                } else if (value == "In") {
                                  context.read<EmployeeListBloc>().add(
                                        GetActiveEmployeeListEvent(),
                                      );
                                }
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: "Out",
                                  child: Text('All'),
                                ),
                                const PopupMenuItem<String>(
                                  value: "In",
                                  child: Text('Active'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                            itemCount: length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    Image.network(employeeList
                                        .result[index].profilePicture),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Text(
                                          'Full Name: ',
                                          style: textStyleF18W600(),
                                        ),
                                        Text(
                                          employeeList.result[index].fullName,
                                          style: textStyleF18W400(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          'Email: ',
                                          style: textStyleF18W600(),
                                        ),
                                        Text(
                                          employeeList.result[index].email,
                                          style: textStyleF18W400(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          'Phone: ',
                                          style: textStyleF18W600(),
                                        ),
                                        Text(
                                          employeeList
                                              .result[index].phoneNumber,
                                          style: textStyleF18W400(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          'Sex: ',
                                          style: textStyleF18W600(),
                                        ),
                                        Text(
                                          employeeList.result[index].sex,
                                          style: textStyleF18W400(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          'Designation: ',
                                          style: textStyleF18W600(),
                                        ),
                                        Text(
                                          employeeList
                                              .result[index].designation,
                                          style: textStyleF18W400(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          'Joining Date: ',
                                          style: textStyleF18W600(),
                                        ),
                                        Text(
                                          DateFormatter.formatDateTimeApi(
                                                  employeeList.result[index]
                                                      .joiningDate)
                                              .split('T')[0],
                                          style: textStyleF18W400(),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ),
              );
            } else if (state is EmployeeListLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is EmployeeListFailureState) {
              return const Center(
                child: Text("Data not found"),
              );
            } else if (state is ActiveEmployeeListSuccessState) {
              activeEmployeeList = state.activeEmployeeListResponseModel;

              return RefreshIndicator(
                onRefresh: () async {
                  //_cmd = true;
                  context.read<EmployeeListBloc>().add(
                        GetActiveEmployeeListEvent(),
                      );
                },
                child: SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Text(
                              "Active Employees",
                              style: textStyleF22W700(),
                            ),
                            const Spacer(),
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                print("Selected value: $value");

                                if (value == "Out") {
                                  context.read<EmployeeListBloc>().add(
                                        GetEmployeeListEvent(),
                                      );
                                } else if (value == "In") {
                                  context.read<EmployeeListBloc>().add(
                                        GetActiveEmployeeListEvent(),
                                      );
                                }
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: "Out",
                                  child: Text('All'),
                                ),
                                const PopupMenuItem<String>(
                                  value: "In",
                                  child: Text('Active'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      activeEmployeeList?.result != null
                          ? Expanded(
                              child: ListView.builder(
                                  itemCount: activeEmployeeList?.result.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Office Status: ',
                                                style: textStyleF18W600(),
                                              ),
                                              Text(
                                                activeEmployeeList
                                                        ?.result[index]
                                                        .officeStatus ??
                                                    "",
                                                style: textStyleF18W400(),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                        ],
                                      ),
                                    );
                                  }),
                            )
                          : const Center(
                              child: Text('Data Not Found'),
                            )
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
