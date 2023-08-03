import 'package:assignment_app/features/employee/data/models/employee_list_response_model.dart';

abstract class GetEmployeeLocalDataSource {
  EmployeeResponseModel getEmployees();
  Future<void> setEmployees({required EmployeeResponseModel model});
}
