import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';

import 'package:tell_me/helpers/photo_utility.dart';
import 'package:tell_me/models/news.dart';
import 'package:tell_me/services/sqflite.dart';

class SaveImageDemoSQLite extends StatefulWidget {


  final String title = "Flutter Save Image";

  @override
  _SaveImageDemoSQLiteState createState() => _SaveImageDemoSQLiteState();
}

class _SaveImageDemoSQLiteState extends State<SaveImageDemoSQLite> {
  //
  Future<File> imageFile;
  Image image;

  List<String> images;

  @override
  void initState() {
    super.initState();
    images = [];
   // refreshImages();
  }
  String imgString;
  refreshImages() {
    images.clear();
    MySql().getData().then((value) {

      value.forEach((element) {

        images.add(element.sourceName);
      });
    }).whenComplete(() {
      setState(() {

      });
    });

  }

  pickImageFromGallery() async {
/*    XFile _pickedResturantImage;
    final pickedImageFile = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 20);
    setState(() {
      print("dasdsaasd ${pickedImageFile.toString()}");
      _pickedResturantImage = pickedImageFile;
    });*/
    ImagePicker().pickImage(source: ImageSource.gallery).then((imgFile) async {
      File file = File(imgFile.path);
      print("dasdsaasd ${imgFile.toString()}");
      print("dasdsaasd ${file.toString()}");
       imgString = Utility.base64String(file.readAsBytesSync());
       setState(() {

       });
      print("dasdsaasd ${imgString.toString()}");
      NewsModel newss=NewsModel(
        url: '2112',
        title: "21",
        description: "21",
        urlToImage: "321312",
        publishedAt: "#12",
        sourceName: imgString,
      );
     // await MySql().insertDateBase(newss);
    // refreshImages();
    });
  }

  gridView() {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: images.map((photo) {
          return Utility.imageFromBase64String(photo);
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
           IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              pickImageFromGallery();
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            imgString!=null?Image.memory(
              base64Decode(imgString),
              fit: BoxFit.fill,
            ):SizedBox(),
            Flexible(
              child: gridView(),
            )
          ],
        ),
      ),
    );
  }
}