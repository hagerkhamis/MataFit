import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../../core/utils/functions/setup_service_locator.dart';
import '../../../../../../core/utils/network/api/network_api.dart';
import '../../../../../../core/utils/network/network_request.dart';
import '../../../../../../core/utils/network/network_utils.dart';
import 'package:gyms/features/auth/login/data/models/login_model/login_model/employee_model.dart';

typedef LoginResponse = Either<String, EmployeeModel>;

abstract class LoginRemoteDataSource {
  Future<LoginResponse> login(String phone, String password);
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  @override
  Future<LoginResponse> login(String phone, String password) async {
    LoginResponse loginResponse = left("");

    var body = {
      "phone": phone.trim(),
      "user_pass": password,
    };
    await getIt<NetworkRequest>().requestFutureData<EmployeeModel>(
      Method.post,
      formData: FormData.fromMap(body),
      isFormData: true,
      url: NewApi.doServerLoginApiCall,
      newBaseUrl: NewApi.baseUrl,
      onSuccess: (data) {
        if (data.status == 200 || data.status == 1) {
          loginResponse = right(data);
        } else {
          loginResponse = left(data.message ?? "Login Failed");
        }
      },
      onError: (code, msg) {
        loginResponse = left(msg.toString());
      },
    );
    return loginResponse;
  }
}
