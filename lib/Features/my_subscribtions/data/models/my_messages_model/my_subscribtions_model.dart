import 'package:gyms/core/utils/functions/base_one_response.dart';
import 'package:gyms/features/my_subscribtions/data/models/my_messages_model/my_subscribtions.dart';

class MySubscribtionsModel extends BaseOneResponse {
  const MySubscribtionsModel({
    super.status,
    super.data,
    super.message,
  });

  factory MySubscribtionsModel.fromJson(Map<String, dynamic> json) {
    return MySubscribtionsModel(
      status: int.tryParse(json['status'].toString()),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MySubscribtions.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
