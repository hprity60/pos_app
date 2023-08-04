import 'package:assignment_app/features/employee/data/models/employee_list_response_model.dart';

import '../../models/active_employee_list_response_model.dart';

abstract class GetEmployeeLocalDataSource {
  EmployeeResponseModel getEmployees();
  ActiveEmployeeListResponseModel getActiveEmployees();
  Future<void> setEmployees({required EmployeeResponseModel model});
  Future<void> setActiveEmployees({required ActiveEmployeeListResponseModel model});
}
