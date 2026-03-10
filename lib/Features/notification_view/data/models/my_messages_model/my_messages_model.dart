import 'datum.dart';

class MyMessagesModel {
  int? status;
  String? message;
  List<Datum>? data;

  MyMessagesModel({this.status, this.message, this.data});

  factory MyMessagesModel.fromJson(Map<String, dynamic> json) {
    return MyMessagesModel(
      status: int.tryParse(json['status'].toString()),
      message: json['message'] as String?,
      data: (json['data'] != null)
          ? (json['data'] as List<dynamic>?)
              ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
