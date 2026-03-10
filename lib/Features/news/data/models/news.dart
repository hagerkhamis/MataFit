import 'package:gyms/features/news/domain/entities/news.dart';

typedef AllNewsList = List<News>?;

class News extends NewsEntity {
  const News(
      {super.newsId,
      super.detailsAr,
      super.mainImage,
      super.newsDate,
      super.newsTitleAr});

  factory News.fromJson(Map<String, dynamic> json) => News(
        newsId: json["news_id"],
        detailsAr: json["details_ar"],
        mainImage: json["main_image"],
        newsDate: json["news_date"],
        newsTitleAr: json["news_title_ar"],
      );

  Map<String, dynamic> toJson() => {
        "news_id": newsId,
        "details_ar": detailsAr,
        "main_image": mainImage,
        "news_date": newsDate,
        "news_title_ar": newsTitleAr,
      };
}
