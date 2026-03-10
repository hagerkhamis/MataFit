import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gyms/features/auth/login/data/models/login_model/login_model/employee_model.dart';

import '../../../../../../core/utils/network/network_request.dart';
import '../../../../../core/utils/functions/setup_service_locator.dart';
import '../../../../../core/utils/network/api/network_api.dart';
import '../../../../../core/utils/network/network_utils.dart';

typedef GetProfileResponse = Either<String, EmployeeModel>;

abstract class GetProfileRemoteDataSource {
  Future<GetProfileResponse> getProfile(
    String userId,
  );
}

class GetProfileRemoteDataSourceImpl extends GetProfileRemoteDataSource {
  @override
  Future<GetProfileResponse> getProfile(
    String userId,
  ) async {
    GetProfileResponse getProfileResponse = left("");

    var body = {
      "mem_id": userId,
    };

    await getIt<NetworkRequest>().requestFutureData<EmployeeModel>(
      Method.post,
      params: body,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: NewApi.doServerGetProfileApiCall,
      newBaseUrl: NewApi.baseUrl,
      onSuccess: (data) {
        if (data.status == 200) {
          getProfileResponse = right(data);
        } else {
          getProfileResponse = left(data.message.toString());
        }
      },
      onError: (code, msg) {
        getProfileResponse = left(code.toString());
      },
    );
    return getProfileResponse;
  }
}
