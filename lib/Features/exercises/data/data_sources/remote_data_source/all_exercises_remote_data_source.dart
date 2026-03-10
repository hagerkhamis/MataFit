import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gyms/features/exercises/data/models/my_messages_model/exercise.dart';
import 'package:gyms/features/exercises/data/models/my_messages_model/exercise_cat_model.dart';
import 'package:gyms/core/utils/functions/setup_service_locator.dart';

import '../../../../../../core/utils/network/api/network_api.dart';
import '../../../../../../core/utils/network/network_request.dart';
import '../../../../../../core/utils/network/network_utils.dart';
import '../../models/my_messages_model/exercise_cat.dart';
import '../../models/my_messages_model/exercise_model.dart';

typedef AllExercisesResponse = Either<String, AllExercisesList>;
typedef AllExercisescatResponse = Either<String, AllExercisesCatList>;

abstract class AllExercisesRemoteDataSource {
  Future<AllExercisescatResponse> fetchAllExercisesCat(String userId);
  Future<AllExercisesResponse> fetchAllExercises(String catId);
}

class AllExercisesRemoteDataSourceImpl extends AllExercisesRemoteDataSource {
  @override
  Future<AllExercisesResponse> fetchAllExercises(String catId) async {
    AllExercisesResponse allExercisesResponse = left("");
    var body = {"page": "1", "per_page": "100", "cat_id": catId};
    await getIt<NetworkRequest>().requestFutureData<ExerciseModel>(
      Method.post,
      params: body,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: NewApi.doServerGetExercisesList,
      newBaseUrl: NewApi.baseUrl,
      onSuccess: (data) {
        if (data.status == 200 && data.data != null) {
          allExercisesResponse = right(data.data!);
        } else if (data.status == 200 && data.data == null) {
          allExercisesResponse = left(data.message!);
        } else {
          allExercisesResponse = left(data.message!);
        }
      },
      onError: (code, msg) {
        allExercisesResponse = left(code.toString());
      },
    );
    return allExercisesResponse;
  }

  @override
  Future<AllExercisescatResponse> fetchAllExercisesCat(String userId) async {
    AllExercisescatResponse allExercisesCatResponse = left("");
    var body = {"page": "1", "per_page": "100"};
    await getIt<NetworkRequest>().requestFutureData<ExerciseCatModel>(
      Method.post,
      params: body,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: NewApi.doServerExercisesCat,
      newBaseUrl: NewApi.baseUrl,
      onSuccess: (data) {
        if (data.status == 200 && data.data != null) {
          allExercisesCatResponse = right(data.data!);
        } else if (data.status == 200 && data.data == null) {
          allExercisesCatResponse = left(data.message!);
        } else {
          allExercisesCatResponse = left(data.message!);
        }
      },
      onError: (code, msg) {
        allExercisesCatResponse = left(code.toString());
      },
    );
    return allExercisesCatResponse;
  }
}
