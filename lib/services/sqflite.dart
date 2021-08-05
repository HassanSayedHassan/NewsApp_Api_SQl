import 'dart:convert';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tell_me/models/news.dart';
import 'dart:io' as io;
class MySql {
  String table = 'news_table';
  static Database _db;

  Future<Database> get db async{
    if(_db == null){
      _db = await initialDB();
      return _db;
    }else{
      return _db;
    }
  }

  initialDB() async{
    io.Directory docDirect = await getApplicationDocumentsDirectory();
    String path = join(docDirect.path,'news.db');
    var mydb = await openDatabase(path,version: 1,onCreate: (Database db,int version) async{
      await db.execute(
          'CREATE TABLE "$table" (id INTEGER PRIMARY KEY, sourceName TEXT, title Text,description TEXT, url Text, urlToImage TEXT, publishedAt Text)');
      print('Notes Table Created');
    });
    return mydb;
  }

  Future<void> insertDateBase(NewsModel news) async {
    var dbclient = await db;
    await dbclient.insert(table, news.toJason()).then((value) {
      print('inserted1: $value');
    });
  }

  Future<List<NewsModel>> getData() async{
    List<NewsModel> newsModelList=[];
    var dbclient = await db;
    await dbclient.query(table).then((value) {
      value.forEach((element) {
        NewsModel news = NewsModel.fromJson(element);
        newsModelList.add(news);
      });
    });
   return newsModelList;
  }

  Future<int> update(NewsModel oldNews,NewsModel newNews) async {
    var dbclient = await db;
    return await dbclient.update(table, newNews.toJason(),
        where: 'sourceName = ?', whereArgs: [oldNews.sourceName]).whenComplete(() {
          print("Updated");
    });
  }
  Future<void> delete(int id) async {
    var dbclient = await db;
    return await dbclient.delete(table, where: 'title = ?', whereArgs: ['21']).whenComplete(() {
      print ("Deleted");
    });
  }

  Future<void> deleteAll() async {
    var dbclient = await db;
    return await dbclient.delete(table).whenComplete(() {
      print ("Deleted");
    });
  }
}
