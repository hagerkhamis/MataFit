import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gyms/core/utils/constants.dart';
import 'package:gyms/core/utils/functions/setup_service_locator.dart';
import 'package:gyms/features/auth/login/domain/entities/employee_entity.dart';
import 'package:gyms/features/subscribtions/data/models/delete_and_add_model.dart';
import 'package:hive/hive.dart';

import '../../../../../core/utils/network/api/network_api.dart';
import '../../../../../core/utils/network/network_request.dart';
import '../../../../../core/utils/network/network_utils.dart';

typedef SendInvitationResponse = Either<String, String>;

abstract class SendInvitationRemoteDataSource {
  Future<SendInvitationResponse> sendInvitation(phone, name);
}

class SendInvitationRemoteDataSourceImpl
    extends SendInvitationRemoteDataSource {
  @override
  Future<SendInvitationResponse> sendInvitation(phone, name) async {
    SendInvitationResponse sendInvitationResponse = left("");
    var box = Hive.box<EmployeeEntity>(kEmployeeDataBox);

    var body = {
      "phone": phone,
      "person_name": name,
      "mem_id": box.get(kEmployeeDataBox)!.memId
    };
    await getIt<NetworkRequest>().requestFutureData<DeleteAndAddModel>(
      Method.post,
      params: body,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: NewApi.doServerSendInvitation,
      newBaseUrl: NewApi.baseUrl,
      onSuccess: (data) {
        if (data.status == 200) {
          sendInvitationResponse = right(data.message!);
        } else {
          sendInvitationResponse = left(data.message!);
        }
      },
      onError: (code, msg) {
        sendInvitationResponse = left(code.toString());
      },
    );
    return sendInvitationResponse;
  }
}
