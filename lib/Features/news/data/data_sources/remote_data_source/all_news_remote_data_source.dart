import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gyms/core/utils/functions/setup_service_locator.dart';

import '../../../../../../core/utils/network/api/network_api.dart';
import '../../../../../../core/utils/network/network_request.dart';
import '../../../../../../core/utils/network/network_utils.dart';
import '../../models/news.dart';
import '../../models/my_news_model.dart';

typedef AllNewsResponse = Either<String, AllNewsList>;

abstract class AllNewsRemoteDataSource {
  Future<AllNewsResponse> fetchAllNews(String userId);
}

class AllNewsRemoteDataSourceImpl extends AllNewsRemoteDataSource {
  @override
  Future<AllNewsResponse> fetchAllNews(String userId) async {
    AllNewsResponse allNewsResponse = left("");
    var body = {"page": "1", "per_page": "100", "mem_id": userId};
    await getIt<NetworkRequest>().requestFutureData<MyNewsModel>(
      Method.post,
      params: body,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: NewApi.doServerGetNewsList,
      newBaseUrl: NewApi.baseUrl,
      onSuccess: (data) {
        if ((data.status == 200 || data.status == 1) && data.data != null) {
          allNewsResponse = right(data.data!);
        } else {
          allNewsResponse = left(data.message ?? "No News Found");
        }
      },
      onError: (code, msg) {
        allNewsResponse = left(code.toString());
      },
    );
    return allNewsResponse;
  }
}
