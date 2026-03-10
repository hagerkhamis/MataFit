import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gyms/core/utils/functions/setup_service_locator.dart';

import '../../../../../../core/utils/network/api/network_api.dart';
import '../../../../../../core/utils/network/network_request.dart';
import '../../../../../../core/utils/network/network_utils.dart';
import '../../models/my_messages_model/offers.dart';
import '../../models/my_messages_model/my_offers_model.dart';

typedef AllOffersResponse = Either<String, AllOffersList>;

abstract class AllOffersRemoteDataSource {
  Future<AllOffersResponse> fetchAllOffers(String userId);
}

class AllOffersRemoteDataSourceImpl extends AllOffersRemoteDataSource {
  @override
  Future<AllOffersResponse> fetchAllOffers(String userId) async {
    AllOffersResponse allOffersResponse = left("");
    var body = {"page": "1", "per_page": "100", "mem_id": userId};
    await getIt<NetworkRequest>().requestFutureData<MyOffersModel>(
      Method.post,
      params: body,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: NewApi.doServerGetOfferList,
      newBaseUrl: NewApi.baseUrl,
      onSuccess: (data) {
        if (data.status == 200 && data.data != null) {
          allOffersResponse = right(data.data!);
        } else if (data.status == 200 && data.data == null) {
          allOffersResponse = left(data.message!);
        } else {
          allOffersResponse = left(data.message!);
        }
      },
      onError: (code, msg) {
        allOffersResponse = left(code.toString());
      },
    );
    return allOffersResponse;
  }
}
