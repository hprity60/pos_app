import 'package:assignment_app/features/employee/data/models/employee_list_response_model.dart';

abstract class GetEmployeeRemoteDataSource {
  Future<EmployeeResponseModel> getEmployeeList();
}
