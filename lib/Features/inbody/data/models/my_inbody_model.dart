import 'package:gyms/core/utils/functions/base_one_response.dart';
import 'package:gyms/features/inbody/data/models/all_inbody.dart';


class MyInbodyModel extends BaseOneResponse {
  const MyInbodyModel({
    super.status,
    super.data,
    super.message,
  });

  factory MyInbodyModel.fromJson(Map<String, dynamic> json) {
    return MyInbodyModel(
      status: int.tryParse(json['status'].toString()),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AllInbody.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
