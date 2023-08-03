// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:assignment_app/features/employee/domain/repositories/get_remote_repository.dart';

import '../../data/models/employee_list_response_model.dart';

part 'employee_list_event.dart';
part 'employee_list_state.dart';

class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState> {
  final GetEmployeeListRepository getEmployeeListRepository;
  EmployeeListBloc({
    required this.getEmployeeListRepository,
  }) : super(EmployeeListInitial()) {
    on<GetEmployeeListEvent>((event, emit) async {
      emit(EmployeeListLoadingState());

      try {
        final EmployeeResponseModel employeeData =
            await getEmployeeListRepository.getEmployeeList();
        emit(EmployeeListSuccessState(employeeResponseModel: employeeData));
      } on DioException {
        rethrow;
      } catch (e) {
        rethrow;
      }
    });
  }
}
