import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gyms/core/utils/constants.dart';
import 'package:gyms/core/utils/functions/setup_service_locator.dart';
import 'package:gyms/features/inbody/data/models/all_inbody.dart';
import 'package:hive/hive.dart';
import '../../../../../../core/utils/network/api/network_api.dart';
import '../../../../../../core/utils/network/network_request.dart';
import '../../../../../../core/utils/network/network_utils.dart';
import '../../../../auth/login/domain/entities/employee_entity.dart';
import '../../models/my_inbody_model.dart';

typedef AllInbodyResponse = Either<String, AllInbodyList>;

abstract class AllInbodyRemoteDataSource {
  Future<AllInbodyResponse> fetchAllInbody(String userId);
}

class AllInbodyRemoteDataSourceImpl extends AllInbodyRemoteDataSource {
  @override
  Future<AllInbodyResponse> fetchAllInbody(String userId) async {
    var box = Hive.box<EmployeeEntity>(kEmployeeDataBox);
    AllInbodyResponse allInbodyResponse = left("");
    var body = {
      "page": "1",
      "per_page": "100",
      "mem_id": box.get(kEmployeeDataBox)!.memId
      //   "mem_id": "55"
    };
    await getIt<NetworkRequest>().requestFutureData<MyInbodyModel>(
      Method.post,
      params: body,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: NewApi.doServerGetInbodyList,
      newBaseUrl: NewApi.baseUrl,
      onSuccess: (data) {
        if (data.status == 200 && data.data != null) {
          allInbodyResponse = right(data.data!);
        } else if (data.status == 200 && data.data == null) {
          allInbodyResponse = left(data.message!);
        } else {
          allInbodyResponse = left(data.message!);
        }
      },
      onError: (code, msg) {
        allInbodyResponse = left(code.toString());
      },
    );
    return allInbodyResponse;
  }
}
