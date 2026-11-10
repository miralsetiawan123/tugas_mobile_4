import 'dart:convert';
import 'package:http/http.dart' as http;
import 'article_model.dart';

class ApiService {
  static const _apiKey = 'YOUR_API_KEY_HERE'; // GANTI DENGAN API KEY ANDA

  Future<List<Article>> fetchArticles() async {
    try {
      final uri = Uri.https('newsapi.org', '/v2/top-headlines', {
        'country': 'id',
        'apiKey': _apiKey,
      });

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final List<dynamic> articlesJson = json['articles'] ?? [];

        return articlesJson
            .whereType<Map<String, dynamic>>()
            .where((j) => j['title'] != null && j['title'] != '[Removed]')
            .map((j) => Article.fromJson(j))
            .toList();
      } else {
        throw Exception('Failed to load articles (${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}