import 'package:flutter/cupertino.dart';

class NewsModel {
  @required
  String sourceName;
  @required
  String title;
  @required
  String description;
  @required
  String url;
  @required
  String urlToImage;
  @required
  String publishedAt;

  NewsModel(
      {this.sourceName = 'NULL',
      this.title = 'NULL',
      this.description = 'NULL',
      this.url = 'NULL',
      this.urlToImage = 'NULL',
      this.publishedAt = 'NULL'});

  NewsModel.fromJson(Map<String,dynamic> data){
    sourceName = data['sourceName'];
    title = data['title'];
    description = data['description'];
    url = data['url'];
    urlToImage = data['urlToImage'];
    publishedAt = data['publishedAt'];

  }
  Map<String, dynamic> toJason() => {
        'sourceName': sourceName,
        'title': title,
        'description': description,
        'url': url,
        'urlToImage': urlToImage,
        'publishedAt': publishedAt
      };


}
