

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


class HelpFun{

 void  closeLoading(context) {

 Navigator.pop(context); //pop dialog

 }

 void showToast(context,mess){
   Toast.show(mess, context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER,backgroundColor: Colors.teal);
 }


}
