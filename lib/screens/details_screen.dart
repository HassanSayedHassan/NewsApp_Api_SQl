import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tell_me/helpers/help_fun.dart';
import 'package:tell_me/helpers/photo_utility.dart';
import 'package:tell_me/models/news.dart';
import 'package:tell_me/widgets/api_handlar.dart';

class DetailsScreen extends StatelessWidget {
  final NewsModel news;
  DetailsScreen(this.news);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Column(
        children: [
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: news.urlToImage != null
                    ? MemoryImage(Utility().ConvertStringToImage(news.urlToImage))
                    : AssetImage("assets/images/bbc.png"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  parseHumanDateTime(news.publishedAt),
                  textAlign: TextAlign.start,
                  style: GoogleFonts.roboto(
                    textStyle:
                    TextStyle(color: Colors.black87, letterSpacing: 0.5),
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Flexible(
                  child: Text(
                     news.title,
                    textAlign: TextAlign.end,
                    style: GoogleFonts.abrilFatface(
                      textStyle:
                      TextStyle(color: Colors.black87, letterSpacing: 0.5),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 3,
            color:Color(0xff707070) ,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    news.description,
                    textAlign: TextAlign.end,
                    style: GoogleFonts.abrilFatface(
                      textStyle:
                      TextStyle(color: Colors.black87, letterSpacing: 0.5),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: drowbtn(context)),
          )
        ],
      ),
    ));
  }
  Widget drowbtn(context) {
    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: news.url));
        HelpFun().showToast(context, 'url  copy to clipboard ');
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 60, vertical: 40),
        decoration: BoxDecoration(
            color: Colors.teal, borderRadius: BorderRadius.circular(40)),
        width: double.infinity,
        height: 50,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.share,
              color: Colors.white,
            ),
            SizedBox(
              width: 40,
            ),
            Text(
              'share',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(color: Colors.white, letterSpacing: 0.5),
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
