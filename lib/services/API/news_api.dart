import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/news models/article_model.dart';

class ApiService {
  final endPointUrl = "newsapi.org"; // Corrected URL
  final client = http.Client();

  Future<List<Article>> getArticle() async {
    final queryParameters = {
      'country': 'us',
      'category': 'business',
      'apiKey': 'fe9af4c0f27a4daabc6ad60f5281d004',
    };
    final uri = Uri.https(endPointUrl, '/v2/top-headlines', queryParameters);
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['articles'];
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();
      return articles;
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
