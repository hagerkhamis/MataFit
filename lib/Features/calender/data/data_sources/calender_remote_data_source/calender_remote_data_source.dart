import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gyms/features/calender/data/models/calender_model/calender_model.dart';
import 'package:gyms/core/utils/functions/setup_service_locator.dart';
import '../../../../../core/utils/network/api/network_api.dart';
import '../../../../../core/utils/network/network_request.dart';
import '../../../../../core/utils/network/network_utils.dart';

typedef CalenderResponse = Either<String, CalenderList>;

abstract class CalenderRemoteDataSource {
  Future<CalenderResponse> fetchCalenderData(String month, String empId);
}

class CalenderRemoteDataSourceImpl extends CalenderRemoteDataSource {
  @override
  Future<CalenderResponse> fetchCalenderData(String month, String empId) async {
    CalenderResponse loginResponse = left("");

    var body = {
      "emp_id_fk": empId.trim(),
      "month": month.trim(),
    };
    await getIt<NetworkRequest>().requestFutureData<CalenderModel>(
      Method.post,
      params: body,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: Api.doServerCalenderApiCall,
      onSuccess: (data) {
        if (data.status == 200) {
          loginResponse = right(data.data);
        } else {
          loginResponse = left(data.message!);
        }
      },
      onError: (code, msg) {
        loginResponse = left(code.toString());
      },
    );
    return loginResponse;
  }
}
