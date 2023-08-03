// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:assignment_app/core/network/network_info.dart';
import 'package:assignment_app/features/employee/data/datasources/local_data_source/get_employee_local_data_source.dart';
import 'package:assignment_app/features/employee/data/models/employee_list_response_model.dart';
import 'package:assignment_app/features/employee/domain/repositories/get_remote_repository.dart';
import 'package:dio/dio.dart';

import '../datasources/remote_data_source/get_employee_remote_data_source.dart';

class GetEmployeeListRepositoryImpl extends GetEmployeeListRepository {
  final GetEmployeeRemoteDataSource getEmployeeRemoteDataSource;
  final GetEmployeeLocalDataSource getEmployeeLocalDataSource;
  final NetworkInfo networkInfo;
  GetEmployeeListRepositoryImpl({
    required this.getEmployeeRemoteDataSource,
    required this.getEmployeeLocalDataSource,
    required this.networkInfo,
  });
  @override
  Future<EmployeeResponseModel> getEmployeeList() async {
    if (await networkInfo.isConnected) {
      try {
        final EmployeeResponseModel employeeResponseModel =
            await getEmployeeRemoteDataSource.getEmployeeList();
        await getEmployeeLocalDataSource.setEmployees(
            model: employeeResponseModel);
        return employeeResponseModel;
      } on DioException {
        rethrow;
      } catch (e) {
        rethrow;
      }
    } else {
      final cachedEmployee = getEmployeeLocalDataSource.getEmployees();
      return cachedEmployee;
    }
  }
}
