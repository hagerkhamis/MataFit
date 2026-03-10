import 'package:gyms/core/utils/functions/base_one_response.dart';
import 'package:gyms/features/subscribtions/data/models/my_messages_model/subscribtions.dart';

class SubscribtionsModel extends BaseOneResponse {
  const SubscribtionsModel({
    super.status,
    super.data,
    super.message,
  });

  factory SubscribtionsModel.fromJson(Map<String, dynamic> json) {
    return SubscribtionsModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Subscribtions.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
