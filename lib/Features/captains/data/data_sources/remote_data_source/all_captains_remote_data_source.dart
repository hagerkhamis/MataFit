import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gyms/core/utils/functions/setup_service_locator.dart';
import 'package:gyms/features/captains/data/models/captains.dart';
import 'package:gyms/features/captains/data/models/captains_model.dart';

import '../../../../../../core/utils/network/api/network_api.dart';
import '../../../../../../core/utils/network/network_request.dart';
import '../../../../../../core/utils/network/network_utils.dart';

typedef AllCaptainsResponse = Either<String, AllCaptainsList>;

abstract class AllCaptainsRemoteDataSource {
  Future<AllCaptainsResponse> fetchAllCaptains(String userId);
}

class AllCaptainsRemoteDataSourceImpl extends AllCaptainsRemoteDataSource {
  @override
  Future<AllCaptainsResponse> fetchAllCaptains(String userId) async {
    AllCaptainsResponse allNewsResponse = left("");
    var body = {"page": "1", "per_page": "100"};
    await getIt<NetworkRequest>().requestFutureData<CaptainsModel>(
      Method.post,
      params: body,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: NewApi.doServerGetCaptainsList,
      newBaseUrl: NewApi.baseUrl,
      onSuccess: (data) {
        if ((data.status == 200 || data.status == 1) && data.data != null) {
          allNewsResponse = right(data.data!);
        } else {
          allNewsResponse = left(data.message ?? "No Captains Found");
        }
      },
      onError: (code, msg) {
        allNewsResponse = left(code.toString());
      },
    );
    return allNewsResponse;
  }
}
