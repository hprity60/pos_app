import '../../data/models/active_employee_list_response_model.dart';
import '../../data/models/employee_list_response_model.dart';

abstract class GetEmployeeListRepository {
  Future<EmployeeResponseModel> getEmployeeList();
  Future<ActiveEmployeeListResponseModel> getActiveEmployeeList();
}
