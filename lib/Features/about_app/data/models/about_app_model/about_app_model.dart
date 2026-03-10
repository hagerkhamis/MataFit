import 'datum.dart';

class AboutAppModel {
  int? status;
  String? message;
  List<Datum>? data;

  AboutAppModel({this.status, this.message, this.data});

  factory AboutAppModel.fromJson(Map<String, dynamic> json) => AboutAppModel(
        status: int.tryParse(json['status'].toString()),
        message: json['message'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
