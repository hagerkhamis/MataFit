import 'package:gyms/core/utils/functions/base_one_response.dart';
import 'package:gyms/features/app_home/domain/entities/ads.dart';

class AdsModel extends BaseOneResponse {
  const AdsModel({
    super.status,
    super.data,
    super.message,
  });

  factory AdsModel.fromJson(Map<String, dynamic> json) {
    return AdsModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Ads.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() =>
      {'status': status, 'message': message, 'data': data};
}

typedef AdsList = List<AdsEntity>?;

class Ads extends AdsEntity {
  const Ads({
    super.id,
    super.title,
    super.details,
    super.fromDate,
    super.toDate,
    super.mainImage,
    super.imagePath,
  });

  factory Ads.fromJson(Map<String, dynamic> json) => Ads(
        id: json['id'],
        title: json['title'],
        details: json['details'],
        fromDate: json['from_date'],
        toDate: json['to_date'],
        mainImage: json['main_image'],
        imagePath: json['image_path'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'details': details,
        'from_date': fromDate,
        'to_date': toDate,
        'main_image': mainImage,
        'image_path': imagePath
      };
}
