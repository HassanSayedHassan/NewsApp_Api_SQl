import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

class Utility {

  ///TODO  Convert XFile To File
 // File file = File(imgFile.path);

  /// Convert String To Image
  Uint8List ConvertStringToImage(String base64String) {

    return  base64Decode(base64String);

  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }


  /// Convert ImageFile To String
  static String base64String(Uint8List data) {
    return base64Encode(data);
  }


  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }


}