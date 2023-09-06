import 'article_model.dart';

class NewsModel {
  NewsModel(this.status, this.totalResults, this.articles);

  String status;
  int totalResults;
  List<Article> articles;

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalResults': totalResults,
      'articles': articles,
    };
  }

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        json['status'],
        json['totalResults'],
        (json['articles'] as List<dynamic>)
            .map((e) => Article.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
