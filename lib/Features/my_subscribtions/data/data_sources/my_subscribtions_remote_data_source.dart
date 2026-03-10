import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gyms/core/utils/constants.dart';
import 'package:gyms/core/utils/functions/setup_service_locator.dart';
import 'package:gyms/features/auth/login/domain/entities/employee_entity.dart';
import 'package:gyms/features/my_subscribtions/data/models/my_messages_model/my_subscribtions.dart';
import 'package:gyms/features/my_subscribtions/data/models/my_messages_model/my_subscribtions_model.dart';
import 'package:hive/hive.dart';

import '../../../../../core/utils/network/api/network_api.dart';
import '../../../../../core/utils/network/network_request.dart';
import '../../../../../core/utils/network/network_utils.dart';

typedef MySubscribtionsResponse = Either<String, AllSubscribtionsList>;

abstract class MySubscribtionsRemoteDataSource {
  Future<MySubscribtionsResponse> fetchAllMosalat();
}

class MySubscribtionsRemoteDataSourceImpl
    extends MySubscribtionsRemoteDataSource {
  @override
  Future<MySubscribtionsResponse> fetchAllMosalat() async {
    MySubscribtionsResponse allMosalatResponse = left("");
    var box = Hive.box<EmployeeEntity>(kEmployeeDataBox);

    var body = {
      "page": "1",
      "per_page": "100",
      "mem_id": box.get(kEmployeeDataBox)!.memId
      //box.get(kEmployeeDataBox)!.memId
    };
    await getIt<NetworkRequest>().requestFutureData<MySubscribtionsModel>(
      Method.post,
      params: body,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: NewApi.doServerGetMySubscribtions,
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
