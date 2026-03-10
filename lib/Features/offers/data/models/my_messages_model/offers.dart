import 'package:gyms/features/offers/domain/entities/offers_entity.dart';

typedef AllOffersList = List<OffersEntity>?;

class Offers extends OffersEntity {
  const Offers({
    super.offerId,
    super.offerName,
    super.subTitle,
    super.fromDate,
    super.toDate,
    super.offerValue,
    super.status,
    super.offerDetails,
    super.image,
    super.imagePath,
    super.checkFav,
    super.rate,
  });

  factory Offers.fromJson(Map<String, dynamic> json) => Offers(
        offerId: json["offer_id"],
        offerName: json["offer_name"],
        subTitle: json["sub_title"],
        fromDate: json["from_date"],
        toDate: json["to_date"],
        offerValue: json["offer_value"],
        status: json["status"],
        offerDetails: json["offer_details"],
        image: json["image"],
        imagePath: json["image_path"],
        checkFav: json["check_fav"],
        rate: json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "offer_id": offerId,
        "offer_name": offerName,
        "sub_title": subTitle,
        "from_date": fromDate,
        "to_date": toDate,
        "offer_value": offerValue,
        "status": status,
        "offer_details": offerDetails,
        "image": image,
        "image_path": imagePath,
        "check_fav": checkFav,
        "rate": rate,
      };
}
