import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gyms/core/utils/functions/setup_service_locator.dart';
import '../../../../../../core/utils/network/api/network_api.dart';
import '../../../../../../core/utils/network/network_request.dart';
import '../../../../../../core/utils/network/network_utils.dart';
import '../models/about_app_model/about_app_model.dart';
import '../models/about_app_model/datum.dart';

typedef AboutAppResponse = Either<String, AboutAppDataList>;

abstract class AboutAppRemoteDataSource {
  Future<AboutAppResponse> fetchAboutAppData();
}

class AboutAppRemoteDataSourceImpl extends AboutAppRemoteDataSource {
  @override
  Future<AboutAppResponse> fetchAboutAppData() async {
    AboutAppResponse aboutAppResponse = left("");

    await getIt<NetworkRequest>().requestFutureData<AboutAppModel>(
      Method.get,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: NewApi.doServerAboutAppApiCall,
      newBaseUrl: NewApi.baseUrl,
      onSuccess: (data) {
        if (data.status == 200 || data.status == 1) {
          aboutAppResponse = right(data.data);
        } else {
          aboutAppResponse = left(data.message ?? "Error");
        }
      },
      onError: (code, msg) {
        aboutAppResponse = left(code.toString());
      },
    );
    return aboutAppResponse;
  }
}
