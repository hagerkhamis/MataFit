import 'package:gyms/features/captains/domain/entities/captains_entity.dart';

typedef AllCaptainsList = List<Captains>?;

class Captains extends CaptainsEntity {
  const Captains(
      {super.id, super.about, super.mainImage, super.imagePath, super.name});

  factory Captains.fromJson(Map<String, dynamic> json) => Captains(
        id: json["id"],
        mainImage: json["main_image"],
        imagePath: json["image_path"],
        about: json["about"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main_image": mainImage,
        "image_path": imagePath,
        "about": about,
        "name": name
      };
}
