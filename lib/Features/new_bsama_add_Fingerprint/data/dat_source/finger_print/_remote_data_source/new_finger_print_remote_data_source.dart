import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gyms/features/new_bsama_add_Fingerprint/data/models/finger_print_model/new_finger_print_model.dart';
import 'package:gyms/core/utils/network/api/network_api.dart';

import '../../../../../../core/utils/functions/setup_service_locator.dart';
import '../../../../../../core/utils/network/network_request.dart';
import '../../../../../../core/utils/network/network_utils.dart';

typedef NewFingerPrintResponse = Either<String, NewFingerPrintModel>;

abstract class NewFingerPrintRemoteDataSource {
  Future<NewFingerPrintResponse> addFingerPrint(
      String empId, dynamic image, String lat, String long);
}

class NewFingerPrintRemoteDataSourceImpl
    extends NewFingerPrintRemoteDataSource {
  @override
  Future<NewFingerPrintResponse> addFingerPrint(
      String empId, dynamic image, String lat, String long) async {
    NewFingerPrintResponse fingerPrintResponse = left("");

    var formData = FormData();
    formData.fields.add(MapEntry("emp_code", empId));
    formData.fields.add(MapEntry("lat", lat));
    formData.fields.add(MapEntry("long", long));

    if (image != null) {
      formData.files.add(MapEntry(
        "emp_img",
        await MultipartFile.fromFile(image.path,
            filename: image.path.split('/').last),
      ));
    }
    await getIt<NetworkRequest>().requestFutureData<NewFingerPrintModel>(
      Method.post,
      formData: formData,
      isFormData: true,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: NewApi.doServerNewBasma,
      newBaseUrl: NewApi.baseUrl,
      onSuccess: (data) {
        if (data.status == 200) {
          fingerPrintResponse = right(data);
        } else {
          fingerPrintResponse = left(data.message.toString());
        }
      },
      onError: (code, msg) {
        fingerPrintResponse = left(msg.toString());
      },
    );
    return fingerPrintResponse;
  }
}
