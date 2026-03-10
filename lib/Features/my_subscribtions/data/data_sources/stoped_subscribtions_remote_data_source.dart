import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gyms/core/utils/constants.dart';
import 'package:gyms/core/utils/functions/setup_service_locator.dart';
import 'package:gyms/features/auth/login/domain/entities/employee_entity.dart';
import 'package:gyms/features/subscribtions/data/models/delete_and_add_model.dart';
import 'package:hive/hive.dart';

import '../../../../../core/utils/network/api/network_api.dart';
import '../../../../../core/utils/network/network_request.dart';
import '../../../../../core/utils/network/network_utils.dart';

typedef StopedSubscribtionsResponse = Either<String, String>;

abstract class StopedSubscribtionsRemoteDataSource {
  Future<StopedSubscribtionsResponse> stopedSubscribtions(
      fromDate, subId, reason, numDays, typeFK);
}

class StopedSubscribtionsRemoteDataSourceImpl
    extends StopedSubscribtionsRemoteDataSource {
  @override
  Future<StopedSubscribtionsResponse> stopedSubscribtions(
      fromDate, subId, reason, numDays, typeFK) async {
    StopedSubscribtionsResponse addSubscribtionsResponse = left("");
    var box = Hive.box<EmployeeEntity>(kEmployeeDataBox);

    var body = {
      "strat_from_date": fromDate,
      "subscription_type_fk": typeFK,
      "mem_id": box.get(kEmployeeDataBox)!.memId,
      "subs_id": subId,
      "stoped_num_days": numDays,
      "stopped_reason": reason
    };
    await getIt<NetworkRequest>().requestFutureData<DeleteAndAddModel>(
      Method.post,
      params: body,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: NewApi.stopedServerSubscribtions,
      newBaseUrl: NewApi.baseUrl,
      onSuccess: (data) {
        if (data.status == 200) {
          addSubscribtionsResponse = right(data.message!);
        } else {
          addSubscribtionsResponse = left(data.message!);
        }
      },
      onError: (code, msg) {
        addSubscribtionsResponse = left(code.toString());
      },
    );
    return addSubscribtionsResponse;
  }
}
