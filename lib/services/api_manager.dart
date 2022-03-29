import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_application2/models/newsmodel.dart';

class ApiManager {
  Future<NewsModel> getNews() async {
    final response = await http.Client().get(Uri.parse(
        'https://newsapi.org/v2/everything?domains=wsj.com&apiKey=c3cd472088e844a88f3de5de5a281014'));

    if (response.statusCode != 200) {
      throw Exception('response code: ${response.statusCode}');
    }

    final jsonString = response.body;

    try {
      final jsonMap = json.decode(jsonString);
      return NewsModel.fromJson(jsonMap);
    } on Exception catch (e) {
      throw Exception('$e');
    }
  }
}
