import 'dart:convert';

import 'package:tell_me/models/news.dart';
import 'package:http/http.dart' as http;
import 'package:tell_me/services/sqflite.dart';

class NewsApi {
  Future<List<NewsModel>> fetChNews() async {
    var url =
        'https://newsapi.org/v2/top-headlines?country=eg&apiKey=93cd206b1988407a99d81aa2e27c19e1';
    var response = await http.get(Uri.parse(url));

    List<NewsModel> newsModels = List<NewsModel>();
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["articles"];

      for (var item in data) {
        NewsModel newsModel = NewsModel(
          sourceName: item["source"]["name"].toString(),
          title: item["title"],
          publishedAt: item["publishedAt"].toString(),
          description: item["description"].toString(),
          urlToImage: item['urlToImage'],
          url: item['url'],
        );
        newsModels.add(newsModel);
        //print(item["title"]);

      }
    }
  ///  newsModels.sort((a,b)=>b.publishedAt.compareTo(a.publishedAt));
    ///



    return newsModels;
  }
  Future<List<NewsModel>> fetChFilterdNews(String sourceName) async {
    var url =
        'https://newsapi.org/v2/top-headlines?country=eg&apiKey=93cd206b1988407a99d81aa2e27c19e1';
    var response = await http.get(Uri.parse(url));

    List<NewsModel> newsModels = List<NewsModel>();
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["articles"];

      for (var item in data) {
        NewsModel newsModel = NewsModel(
          sourceName: item["source"]["name"].toString(),
          title: item["title"],
          publishedAt: item["publishedAt"].toString(),
          description: item["description"].toString(),
          urlToImage: item['urlToImage'],
          url: item['url'],
        );
        newsModels.add(newsModel);
        //print(item["title"]);

      }
    }
    newsModels.removeWhere((element) => element.sourceName!=sourceName);
    return newsModels;
  }
}
