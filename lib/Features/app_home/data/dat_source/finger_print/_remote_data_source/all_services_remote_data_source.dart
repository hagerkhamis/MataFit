import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gyms/features/app_home/data/models/ads_model/ads_model.dart';
import 'package:gyms/features/app_home/data/models/my_services_model/my_services_model.dart';
import 'package:gyms/features/app_home/domain/entities/services_entity.dart';
import 'package:gyms/core/utils/functions/setup_service_locator.dart';

import '../../../../../../core/utils/network/api/network_api.dart';
import '../../../../../../core/utils/network/network_request.dart';
import '../../../../../../core/utils/network/network_utils.dart';

typedef AllServicesResponse = Either<String, ServicesEntity>;
typedef AllAdsResponse = Either<String, AdsList>;

abstract class AllServicesRemoteDataSource {
  Future<AllServicesResponse> fetchAllServices();
  Future<AllAdsResponse> fetchAllAds();
}

class AllServicesRemoteDataSourceImpl extends AllServicesRemoteDataSource {
  @override
  Future<AllServicesResponse> fetchAllServices() async {
    AllServicesResponse allTa3memResponse = left("");

    await getIt<NetworkRequest>().requestFutureData<MyServicesModel>(
      Method.post,
      // params: body,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: NewApi.doServerServicesList,
      newBaseUrl: NewApi.baseUrl,
      onSuccess: (data) {
        if (data.status == 200 && data.data != null) {
          allTa3memResponse = right(data);
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
  
  @override
  Future<AllAdsResponse> fetchAllAds() async{
     AllAdsResponse adsResponse = left("");

    await getIt<NetworkRequest>().requestFutureData<AdsModel>(
      Method.post,
      // params: body,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: NewApi.doServerAdsList,
      newBaseUrl: NewApi.baseUrl,
      onSuccess: (data) {
        if (data.status == 200 && data.data != null) {
          adsResponse = right(data.data!);
        } else if (data.status == 200 && data.data == null) {
          adsResponse = left(data.message!);
        } else {
          adsResponse = left(data.message!);
        }
      },
      onError: (code, msg) {
        adsResponse = left(code.toString());
      },
    );
    return adsResponse;
  }



  
}
