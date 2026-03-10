import '../constants.dart';
import 'entity_factory.dart';

///Basic classes for data analysis
class BaseResponse<T> {
  int? code;
  String? message;
  T? data;
  List<T>? listData = [];

  BaseResponse(this.code, this.message, this.data);

  BaseResponse.fromJson(Map<String, dynamic> json) {
    code = json[AppConstant.code] ?? json['code'] ?? json['status'];
    message = json[AppConstant.message] ?? json['message'] ?? json['msg'];

    // Prioritize parsing the whole JSON as T (useful for *Model classes)
    T? wholeData = EntityFactory.generateOBJ<T>(json);
    if (wholeData != null) {
      data = wholeData;
      return;
    }

    if (json.containsKey(AppConstant.data)) {
      var dataJson = json[AppConstant.data];
      if (dataJson is List) {
        for (var item in dataJson) {
          if (T.toString() == "String") {
            listData!.add(item.toString() as T);
          } else {
            T? itemObj = EntityFactory.generateOBJ<T>(item);
            if (itemObj != null) {
              listData!.add(itemObj);
            }
          }
        }
      } else {
        if (T.toString() == "String") {
          data = dataJson.toString() as T;
        } else if (T.toString() == "Map<dynamic, dynamic>") {
          data = dataJson as T;
        } else {
          data = EntityFactory.generateOBJ<T>(dataJson);
        }
      }
    }
  }
}
