class UserModel {
  final String token;
  final String expires_in;
  final String validTo;
  final User user;
  final bool success;
  final String error;

  UserModel({
    required this.token,
    required this.expires_in,
    required this.validTo,
    required this.user,
    required this.success,
    required this.error,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['result']['token'],
      expires_in: json['expires_in'],
      validTo: json['validTo'],
      user: User.fromJson(json['result']['user']),
      success: json['success'],
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': {
        'token': token,
        'expires_in': expires_in,
        'validTo': validTo,
        'user': user.toJson(),
      },
      'success': success,
      'error': error,
    };
  }
}

class User {
  final String companyId;
  final String companyName;
  final String profilePicture;
  final String userGuidId;
  final int userIntId;
  final int userGroupId;
  final String fullName;
  final String phone;
  final String email;
  final String designation;
  final String regNo;
  final String joinDate;

  User({
    required this.companyId,
    required this.companyName,
    required this.profilePicture,
    required this.userGuidId,
    required this.userIntId,
    required this.userGroupId,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.designation,
    required this.regNo,
    required this.joinDate,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      companyId: json['companyId'],
      companyName: json['companyName'],
      profilePicture: json['profilePicture'],
      userGuidId: json['userGuidId'],
      userIntId: json['userIntId'],
      userGroupId: json['userGroupId'],
      fullName: json['fullName'],
      phone: json['phone'],
      email: json['email'],
      designation: json['designation'],
      regNo: json['regNo'],
      joinDate: json['joinDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyId': companyId,
      'companyName': companyName,
      'profilePicture': profilePicture,
      'userGuidId': userGuidId,
      'userIntId': userIntId,
      'userGroupId': userGroupId,
      'fullName': fullName,
      'phone': phone,
      'email': email,
      'designation': designation,
      'regNo': regNo,
      'joinDate': joinDate,
    };
  }
}