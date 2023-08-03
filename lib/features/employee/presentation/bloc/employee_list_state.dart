part of 'employee_list_bloc.dart';

abstract class EmployeeListState extends Equatable {
  const EmployeeListState();

  @override
  List<Object> get props => [];
}

class EmployeeListInitial extends EmployeeListState {}

class EmployeeListSuccessState extends EmployeeListState {
  final EmployeeResponseModel employeeResponseModel;

  const EmployeeListSuccessState({required this.employeeResponseModel});

  @override
  List<Object> get props => [employeeResponseModel];
}

class EmployeeListLoadingState extends EmployeeListState {
  @override
  List<Object> get props => [];
}

class EmployeeListFailureState extends EmployeeListState {
  final String errorMessage;

  const EmployeeListFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
