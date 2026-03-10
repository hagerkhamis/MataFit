import 'package:gyms/features/auth/login/data/models/login_model/login_model/employee.dart';
import 'package:gyms/core/utils/functions/base_one_response.dart';

class EmployeeModel extends BaseOneResponse {
  const EmployeeModel(
      {super.status, super.data, super.message, super.logoutOption});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : (json['data'] is List<dynamic>
              ? (json['data'] as List<dynamic>?)
                  ?.map((e) => Employee.fromJson(e as Map<String, dynamic>))
                  .toList()
              : Employee.fromJson(json['data'] as Map<String, dynamic>)),
      logoutOption: json['logout_option'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
        'logout_option': logoutOption
      };
}
