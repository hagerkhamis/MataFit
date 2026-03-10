import 'package:gyms/core/utils/functions/base_one_response.dart';

import 'exercise.dart';

class ExerciseModel extends BaseOneResponse {
  const ExerciseModel({
    super.status,
    super.data,
    super.message,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
