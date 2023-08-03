// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:assignment_app/core/values/strings.dart';
import 'package:hive/hive.dart';

import 'package:assignment_app/features/employee/data/datasources/local_data_source/get_employee_local_data_source.dart';
import 'package:assignment_app/features/employee/data/models/employee_list_response_model.dart';

class GetEmployeeLocalDataSourceImpl implements GetEmployeeLocalDataSource {
  final Box box;
  GetEmployeeLocalDataSourceImpl({
    required this.box,
  });
  @override
  EmployeeResponseModel getEmployees() {
    final encoddJson = box.get(AppStrings.localStorageString);
    final model = EmployeeResponseModel.fromJson(encoddJson);
    return model;
  }

  @override
  Future<void> setEmployees({required EmployeeResponseModel model}) async {
    await box.put(AppStrings.localStorageString, model.toJson());
  }
}
