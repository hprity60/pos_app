import 'package:assignment_app/core/network/dio_client.dart';
import 'package:assignment_app/core/network/network_info.dart';
import 'package:assignment_app/core/values/date_formatter.dart';
import 'package:assignment_app/core/values/text_styles.dart';
import 'package:assignment_app/features/employee/data/datasources/local_data_source/get_employee_local_data_source_impl.dart';
import 'package:assignment_app/features/employee/data/models/employee_list_response_model.dart';
import 'package:assignment_app/features/employee/data/repositories/get_employee_repository_impl.dart';
import 'package:assignment_app/features/employee/presentation/bloc/employee_list_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../data/datasources/remote_data_source/get_employee_remote_data_source_impl.dart';

class EmployeeListScreen extends StatelessWidget {
  static const id = "employee_list_screen";
  EmployeeListScreen({super.key});

  String fullName = "";

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
          actions: const [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.filter_list))
          ],
        ),
        body: BlocConsumer<EmployeeListBloc, EmployeeListState>(
          listener: (context, state) {
            if (state is EmployeeListSuccessState) {
              final EmployeeResponseModel model = state.employeeResponseModel;
            }
          },
          builder: (context, state) {
            print("Current State >> $state");

            if (state is EmployeeListSuccessState) {
              final EmployeeResponseModel model = state.employeeResponseModel;
              int length = model.result.length;
              return SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "All Employee",
                      style: textStyleF22W700(),
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
                                  CachedNetworkImage(
                                    imageUrl:
                                        model.result[index].profilePicture,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.transparent,
                                          ),
                                        ],
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                  Image.network(
                                      model.result[index].profilePicture),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Text(
                                        'Full Name: ',
                                        style: textStyleF18W600(),
                                      ),
                                      Text(
                                        model.result[index].fullName,
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
                                        model.result[index].email,
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
                                        model.result[index].phoneNumber,
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
                                        model.result[index].sex,
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
                                        model.result[index].designation,
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
                                                model.result[index].joiningDate)
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
              );
            } else if (state is EmployeeListLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is EmployeeListFailureState) {
              return const Center(
                child: Text("Data not found"),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
