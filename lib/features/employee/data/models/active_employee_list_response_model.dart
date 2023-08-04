class ActiveEmployeeListResponseModel {
  final bool success;
  final List<ActiveEmployee> result;
  final String error;

  ActiveEmployeeListResponseModel({
    required this.success,
    required this.result,
    required this.error,
  });

  factory ActiveEmployeeListResponseModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> resultList = json['result'];
    List<ActiveEmployee> users = resultList.map((userData) => ActiveEmployee.fromJson(userData)).toList();

    return ActiveEmployeeListResponseModel(
      success: json['success'],
      result: users,
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'result': result.map((userData) => userData.toJson()).toList(),
      'error': error,
    };
  }
}

class ActiveEmployee {
  final String userId;
  final String name;
  final String regNo;
  final int clockin;
  final int clockout;
  final String officeStatus;
  final String hasTicket;
  final String ticketId;
  final String clockInTime;

  ActiveEmployee({
    required this.userId,
    required this.name,
    required this.regNo,
    required this.clockin,
    required this.clockout,
    required this.officeStatus,
    required this.hasTicket,
    required this.ticketId,
    required this.clockInTime,
  });

  factory ActiveEmployee.fromJson(Map<String, dynamic> json) {
    return ActiveEmployee(
      userId: json['userId'],
      name: json['name'],
      regNo: json['regNo'],
      clockin: json['clockin'],
      clockout: json['clockout'],
      officeStatus: json['officeStatus'],
      hasTicket: json['hasTicket'],
      ticketId: json['ticketId'],
      clockInTime: json['clockInTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'regNo': regNo,
      'clockin': clockin,
      'clockout': clockout,
      'officeStatus': officeStatus,
      'hasTicket': hasTicket,
      'ticketId': ticketId,
      'clockInTime': clockInTime,
    };
  }
}