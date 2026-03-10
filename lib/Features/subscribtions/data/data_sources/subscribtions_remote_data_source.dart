import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gyms/features/auth/login/domain/entities/employee_entity.dart';
import 'package:gyms/core/utils/constants.dart';
import 'package:gyms/core/utils/functions/setup_service_locator.dart';
import 'package:gyms/features/subscribtions/data/models/my_messages_model/subscribtions.dart';
import 'package:gyms/features/subscribtions/data/models/my_messages_model/subscribtions_model.dart';
import 'package:hive/hive.dart';

import '../../../../../core/utils/network/api/network_api.dart';
import '../../../../../core/utils/network/network_request.dart';
import '../../../../../core/utils/network/network_utils.dart';

typedef AllSubscribtionsResponse = Either<String, AllSubscribtionsList>;

abstract class SubscribtionsRemoteDataSource {
  Future<AllSubscribtionsResponse> fetchAllSubscribtions();
}

class SubscribtionsRemoteDataSourceImpl extends SubscribtionsRemoteDataSource {
  @override
  Future<AllSubscribtionsResponse> fetchAllSubscribtions() async {
    AllSubscribtionsResponse allMosalatResponse = left("");
    var box = Hive.box<EmployeeEntity>(kEmployeeDataBox);

    var body = {
      "page": "1",
      "per_page": "100",
      "branch_id": box.get(kEmployeeDataBox)!.branchIdFk,
      "mem_id": box.get(kEmployeeDataBox)!.memId
    };
    await getIt<NetworkRequest>().requestFutureData<SubscribtionsModel>(
      Method.post,
      params: body,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: NewApi.doServerGetSubscribtions,
      newBaseUrl: NewApi.baseUrl,
      onSuccess: (data) {
        if (data.status == 200 && data.data != null) {
          allMosalatResponse = right(data.data!);
        } else if (data.status == 200 && data.data == null) {
          allMosalatResponse = left(data.message!);
        } else {
          allMosalatResponse = left(data.message!);
        }
      },
      onError: (code, msg) {
        allMosalatResponse = left(code.toString());
      },
    );
    return allMosalatResponse;
  }
}
