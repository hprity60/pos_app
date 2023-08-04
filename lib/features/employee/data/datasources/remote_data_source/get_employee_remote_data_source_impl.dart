// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:assignment_app/core/network/dio_client.dart';
import 'package:assignment_app/core/values/strings.dart';
import 'package:assignment_app/features/employee/data/models/active_employee_list_response_model.dart';
import 'package:assignment_app/features/employee/data/models/employee_list_response_model.dart';
import 'package:dio/dio.dart';

import 'get_employee_remote_data_source.dart';

class GetEmployeeRemoteDataSourceImpl implements GetEmployeeRemoteDataSource {
  DioProvider dio;
  GetEmployeeRemoteDataSourceImpl({
    required this.dio,
  });
  @override
  Future<EmployeeResponseModel> getEmployeeList() async {
    try {
      Response response = await dio.client.get(AppStrings.employeeListUrl);
      final responseBody = response.data;
      final EmployeeResponseModel employeeResponseModel =
          EmployeeResponseModel.fromJson(responseBody);
      return employeeResponseModel;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ActiveEmployeeListResponseModel> getActiveEmployeeList() async {
    try {
      Response response =
          await dio.client.get(AppStrings.activeEmployeeListUrl);
      final responseBody = response.data;
      final ActiveEmployeeListResponseModel activeEmployeeResponseModel =
          ActiveEmployeeListResponseModel.fromJson(responseBody);
      return activeEmployeeResponseModel;
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
