import '../../data/models/employee_list_response_model.dart';

abstract class GetEmployeeListRepository {
  Future<EmployeeResponseModel> getEmployeeList();
}
