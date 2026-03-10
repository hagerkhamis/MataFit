import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gyms/features/introduction/data/models/my_services_model/intro.dart';
import 'package:gyms/features/introduction/data/models/my_services_model/my_intro_model.dart';
import 'package:gyms/core/utils/functions/setup_service_locator.dart';

import '../../../../../core/utils/network/api/network_api.dart';
import '../../../../../core/utils/network/network_request.dart';
import '../../../../../core/utils/network/network_utils.dart';

typedef AllIntroResponse = Either<String, AllIntroList>;

abstract class AllIntroRemoteDataSource {
  Future<AllIntroResponse> fetchAllServices();
}

class AllIntroRemoteDataSourceImpl extends AllIntroRemoteDataSource {
  @override
  Future<AllIntroResponse> fetchAllServices() async {
    AllIntroResponse allTa3memResponse = left("");

    await getIt<NetworkRequest>().requestFutureData<MyIntroModel>(
      Method.post,
      // params: body,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        // headers: {
        //   'Content-Type': 'application/x-www-form-urlencoded',
        //   "lang": "ar",
        // },
      ),
      url: NewApi.doSplashScreens,
      newBaseUrl: CodeApi.baseUrl,

      onSuccess: (data) {
        if (data.status == 200 && data.data != null) {
          allTa3memResponse = right(data.data);
        } else if (data.status == 200 && data.data == null) {
          allTa3memResponse = left(data.message!);
        } else {
          allTa3memResponse = left(data.message!);
        }
      },
      onError: (code, msg) {
        allTa3memResponse = left(code.toString());
      },
    );
    return allTa3memResponse;
  }
}
