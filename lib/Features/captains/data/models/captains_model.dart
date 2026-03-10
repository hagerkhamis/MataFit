import 'package:gyms/core/utils/functions/base_one_response.dart';
import 'package:gyms/features/captains/data/models/captains.dart';

class CaptainsModel extends BaseOneResponse {
  const CaptainsModel({
    super.status,
    super.data,
    super.message,
  });

  factory CaptainsModel.fromJson(Map<String, dynamic> json) {
    return CaptainsModel(
      status: int.tryParse(json['status'].toString()),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Captains.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
