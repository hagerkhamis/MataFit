import '../../../domain/entities/my_subscribtions_entity.dart';

typedef AllSubscribtionsList = List<MySubscribtionsEntity>?;

class MySubscribtions extends MySubscribtionsEntity {
  const MySubscribtions({
    super.subsId,
    super.captainName,
    super.fromDateAr,
    super.haveEgraaStop,
    super.memIdFk,
    super.stopFromAr,
    super.stopToAr,
    super.price,
    super.subsName,
    super.subscriptionTypeFk,
    super.toDateAr,
    super.details,
  });

  factory MySubscribtions.fromJson(Map<String, dynamic> json) =>
      MySubscribtions(
        subsId: json["subs_id"],
        captainName: json["captain_name"],
        fromDateAr: json["from_date_ar"],
        haveEgraaStop: json["have_egraa_stop"],
        memIdFk: json["mem_id_fk"],
        stopFromAr: json["stop_from_ar"],
        stopToAr: json["stop_to_ar"],
        price: json["price"],
        subsName: json["subs_name"],
        subscriptionTypeFk: json["subscription_type_fk"],
        toDateAr: json["to_date_ar"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "subs_id": subsId,
        "captain_name": captainName,
        "from_date_ar": fromDateAr,
        "have_egraa_stop": haveEgraaStop,
        "mem_id_fk": memIdFk,
        "stop_from_ar": stopFromAr,
        "stop_to_ar": stopToAr,
        "price": price,
        "subs_name": subsName,
        "subscription_type_fk": subscriptionTypeFk,
        "to_date_ar": toDateAr,
        "details": details
      };
}
