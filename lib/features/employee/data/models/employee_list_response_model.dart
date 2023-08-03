import 'dart:convert';

List<Employee> employeeFromJson(String str) =>
    List<Employee>.from(json.decode(str).map((x) => Employee.fromJson(x)));

String productModelToJson(List<Employee> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeResponseModel {
  final bool success;
  final List<Employee> result;
  final String error;

  EmployeeResponseModel({
    required this.success,
    required this.result,
    required this.error,
  });

  factory EmployeeResponseModel.fromJson(Map<String, dynamic> json) {
    List<Employee> employees = (json['result'] as List)
        .map((employeeJson) => Employee.fromJson(employeeJson))
        .toList();

    return EmployeeResponseModel(
      success: json['success'],
      result: employees,
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'result': result.map((employee) => employee.toJson()).toList(),
      'error': error,
    };
  }
}

class Employee {
  final String employeeId;
  final String fullName;
  final String designation;
  final String regNo;
  final DateTime dateOfBirth;
  final DateTime joiningDate;
  final String sex;
  final String phoneNumber;
  final String email;
  final String profilePicture;

  Employee({
    required this.employeeId,
    required this.fullName,
    required this.designation,
    required this.regNo,
    required this.dateOfBirth,
    required this.joiningDate,
    required this.sex,
    required this.phoneNumber,
    required this.email,
    required this.profilePicture,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      employeeId: json['employeeId'],
      fullName: json['fullName'],
      designation: json['designation'],
      regNo: json['regNo'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      joiningDate: DateTime.parse(json['joiningDate']),
      sex: json['sex'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      profilePicture: json['profilePicture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'fullName': fullName,
      'designation': designation,
      'regNo': regNo,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'joiningDate': joiningDate.toIso8601String(),
      'sex': sex,
      'phoneNumber': phoneNumber,
      'email': email,
      'profilePicture': profilePicture,
    };
  }
}
