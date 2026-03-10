import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gyms/features/auth/login/data/models/login_model/login_model/employee_model.dart';
import 'package:gyms/features/auth/login/domain/entities/employee_entity.dart';

import '../../../../../../core/utils/network/network_request.dart';
import '../../../../../core/utils/functions/setup_service_locator.dart';
import '../../../../../core/utils/network/api/network_api.dart';
import '../../../../../core/utils/network/network_utils.dart';

typedef UpdateSignatureResponse = Either<String, EmployeeEntity>;

abstract class UpdateSignatureRemoteDataSource {
  Future<UpdateSignatureResponse> updateSignature(
    String userId,
    dynamic attachment,
  );
}

class UpdateSignatureRemoteDataSourceImpl
    extends UpdateSignatureRemoteDataSource {
  @override
  Future<UpdateSignatureResponse> updateSignature(
    String userId,
    dynamic attachment,
  ) async {
    UpdateSignatureResponse updateSignatureResponse = left("");

    var formData = FormData();
    formData.fields.add(MapEntry("emp_id", userId));

    if (attachment != null) {
      formData.files.add(MapEntry(
        "m_image",
        MultipartFile.fromBytes(attachment, filename: "dsds.png"),
      ));
    }

    await getIt<NetworkRequest>().requestFutureData<EmployeeModel>(
      Method.post,
      formData: formData,
      isFormData: true,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: NewApi.doServerUpdateSignatureApiCall,
      newBaseUrl: NewApi.baseUrl,
      onSuccess: (data) {
        if (data.status == 200) {
          updateSignatureResponse = right(data.data);
        } else {
          updateSignatureResponse = left(data.message.toString());
        }
      },
      onError: (code, msg) {
        updateSignatureResponse = left(code.toString());
      },
    );
    return updateSignatureResponse;
  }
}
