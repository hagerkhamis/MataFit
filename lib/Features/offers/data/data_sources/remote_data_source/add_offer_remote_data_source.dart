// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gyms/core/utils/functions/setup_service_locator.dart';

import '../../../../../../core/utils/network/api/network_api.dart';
import '../../../../../../core/utils/network/network_request.dart';
import '../../../../../../core/utils/network/network_utils.dart';
import '../../../../../features/offers/data/models/add_offer_model.dart';
import '../../../../../features/offers/domain/entities/add_offers_entity.dart';

typedef SeenTa3memResponse = Either<String, AddOffersEntity>;

abstract class AddOfferRemoteDataSource {
  Future<SeenTa3memResponse> seenTa3mem(String messageId, String toUserId);
}

class AddOfferRemoteDataSourceImpl extends AddOfferRemoteDataSource {
  @override
  Future<SeenTa3memResponse> seenTa3mem(
      String messageId, String toUserId) async {
    SeenTa3memResponse deleteMessageResponse = left("");
    var body = {
      "offer_id_fk": messageId,
      "mem_id": toUserId,
    };
    await getIt<NetworkRequest>().requestFutureData<AddOfferModel>(
      Method.post,
      params: body,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: NewApi.doServerAddFavOffer,
      newBaseUrl: NewApi.baseUrl,
      onSuccess: (data) {
        if (data.statusCode == 200) {
          deleteMessageResponse = right(data);
        } else {
          deleteMessageResponse = left(data.messageResponse!);
        }
      },
      onError: (code, msg) {
        deleteMessageResponse = left(code.toString());
      },
    );
    return deleteMessageResponse;
  }
}
