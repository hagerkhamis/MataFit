import 'package:gyms/features/privacy_and_policy/domain/entities/privacy_and_policy_entity.dart';

class PrivacyAndPolicyModel extends PrivacyAndPolicyEntity {
  int? status;
  String? message;
  String? data;

  PrivacyAndPolicyModel({this.status, this.message, this.data})
      : super(
          responseMessage: message ?? "",
          statusCode: status ?? 0,
          responseData: data ?? "",
        );

  factory PrivacyAndPolicyModel.fromJson(Map<String, dynamic> json) {
    return PrivacyAndPolicyModel(
      status: int.tryParse(json['status'].toString()),
      message: json['message'] as String?,
      data: json['data'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data,
      };
}
