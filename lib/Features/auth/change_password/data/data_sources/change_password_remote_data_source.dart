import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gyms/features/auth/login/data/models/login_model/login_model/employee_model.dart';
import 'package:gyms/features/auth/login/domain/entities/employee_entity.dart';

import '../../../../../../core/utils/network/network_request.dart';
import '../../../../../core/utils/functions/setup_service_locator.dart';
import '../../../../../core/utils/network/api/network_api.dart';
import '../../../../../core/utils/network/network_utils.dart';

typedef ChangePasswordResponse = Either<String, EmployeeEntity>;

abstract class ChangePasswordRemoteDataSource {
  Future<ChangePasswordResponse> changePassword(
    String userId,
    String confirmUserPass,
    String newPassword,
  );
}

class ChangePasswordRemoteDataSourceImpl
    extends ChangePasswordRemoteDataSource {
  @override
  Future<ChangePasswordResponse> changePassword(
    String userId,
    String confirmUserPass,
    String newPassword,
  ) async {
    ChangePasswordResponse changePasswordResponse = left("");

    var body = {
      "mem_id": userId,
      "confirm_user_pass": confirmUserPass,
      "user_pass": newPassword,
    };
    await getIt<NetworkRequest>().requestFutureData<EmployeeModel>(
      Method.post,
      params: body,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: NewApi.doServerChangePasswordApiCall,
      newBaseUrl: NewApi.baseUrl,
      onSuccess: (data) {
        if (data.status == 200) {
          changePasswordResponse = right(data.data);
        } else {
          changePasswordResponse = left(data.message.toString());
        }
      },
      onError: (code, msg) {
        changePasswordResponse = left(code.toString());
      },
    );
    return changePasswordResponse;
  }
}
