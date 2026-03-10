
import 'package:gyms/features/inbody/domain/entities/Inbody.dart';

typedef AllInbodyList = List<AllInbody>?;

class AllInbody extends AllInbodyEntity {
  const AllInbody(
      {super.created,
      super.dayDate,
      super.forMonth,
      super.forYear,
      super.id,
      super.image,
      super.imagePath,
      super.memCodeFk,
      super.memIdFk,
      super.title,
      super.updated,});

  factory AllInbody.fromJson(Map<String, dynamic> json) => AllInbody(
        created: json["created"],
        dayDate: json["day_date"],
        forMonth: json["for_month"],
        forYear: json["for_year"],
        id: json["id"],
        image: json["image"],
        imagePath: json["image_path"],
        memCodeFk: json["mem_code_fk"],
        memIdFk: json["mem_id_fk"],
        title: json["title"],
        updated: json["updated"],
      );

  Map<String, dynamic> toJson() => {
        "created": created,
        "day_date": dayDate,
        "for_month": forMonth,
        "for_year": forYear,
        "id": id,
        "image": image,
        "image_path": imagePath,
        "mem_code_fk": memCodeFk,
        "mem_id_fk": memIdFk,
        "title": title,
        "updated": updated
      };
}
