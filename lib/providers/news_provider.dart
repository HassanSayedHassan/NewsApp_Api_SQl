
import 'package:flutter/material.dart';
import 'package:tell_me/models/news.dart';

class NewsProvider with ChangeNotifier{

  List<NewsModel> _news = [];

  List<NewsModel> get allNews => _news;

  void setServices() {
    List<NewsModel> myservice=[];


    notifyListeners();
  }

}