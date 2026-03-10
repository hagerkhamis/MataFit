import 'package:gyms/core/utils/functions/base_one_response.dart';

import 'exercise_cat.dart';

class ExerciseCatModel extends BaseOneResponse {
  const ExerciseCatModel({
    super.status,
    super.data,
    super.message,
  });

  factory ExerciseCatModel.fromJson(Map<String, dynamic> json) {
    return ExerciseCatModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ExerciseCat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
