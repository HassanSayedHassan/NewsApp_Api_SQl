import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tell_me/helpers/photo_utility.dart';
import 'package:tell_me/models/news.dart';
import 'package:http/http.dart' as http;
import 'package:tell_me/services/sqflite.dart';
import 'dart:io' as io;
class NewsApi {
  Future<List<NewsModel>> fetChNews() async {
    var url =
        'https://newsapi.org/v2/top-headlines?country=eg&apiKey=93cd206b1988407a99d81aa2e27c19e1';
    var response = await http.get(Uri.parse(url));

    List<NewsModel> newsModels = List<NewsModel>();
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["articles"];
      await MySql().deleteAll();
      for (var item in data) {
        NewsModel newsModel = NewsModel(
          sourceName: item["source"]["name"].toString(),
          title: item["title"],
          publishedAt: item["publishedAt"].toString(),
          description: item["description"].toString(),
          urlToImage: item['urlToImage'],
          url: item['url'],
        );
        if(newsModel.urlToImage!=null)
          {
            var stringImage = await networkImageToBase64(newsModel.urlToImage);

            print("dsadsa  ${stringImage.toString()}");
            newsModel.urlToImage=stringImage;
            await MySql().insertDateBase(newsModel);
            newsModels.add(newsModel);
          }

        //print(item["title"]);

      }
    }
  ///  newsModels.sort((a,b)=>b.publishedAt.compareTo(a.publishedAt));
    ///
    print("length  ${newsModels.length}");
    return newsModels;
  }
  Future<String> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response?.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);
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
