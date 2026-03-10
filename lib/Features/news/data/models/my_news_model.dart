import 'package:gyms/core/utils/functions/base_one_response.dart';

import 'news.dart';

class MyNewsModel extends BaseOneResponse {
  const MyNewsModel({
    super.status,
    super.data,
    super.message,
  });

  factory MyNewsModel.fromJson(Map<String, dynamic> json) {
    return MyNewsModel(
      status: int.tryParse(json['status'].toString()),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => News.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
