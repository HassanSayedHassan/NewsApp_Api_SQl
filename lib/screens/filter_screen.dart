import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tell_me/models/news.dart';
import 'package:tell_me/screens/details_screen.dart';
import 'package:tell_me/services/news_api.dart';
import 'package:tell_me/widgets/api_handlar.dart';
class FilterScreen extends StatefulWidget {
final String sourceName;
FilterScreen(this.sourceName);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<NewsModel> newsModels = [];
  List<AssetImage> assetImage = [
    AssetImage("assets/images/bbc.png"),
    AssetImage("assets/images/masrawy.png"),
    AssetImage("assets/images/youm.jpg")
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              FutureBuilder(
                future: NewsApi().fetChFilterdNews(widget.sourceName),
                builder: (context, AsyncSnapshot snapShot) {
                  switch (snapShot.connectionState) {
                    case ConnectionState.none:
                      return connectionError();
                      break;
                    case ConnectionState.waiting:
                      return loading();
                      break;
                    case ConnectionState.active:
                      return loading();
                      break;
                    case ConnectionState.done:
                      if (snapShot.hasError) {
                        return error(snapShot.error);
                      } else {
                        List<NewsModel> news = snapShot.data;
                        return Expanded(
                          child: GridView.builder(
                            itemCount: news.length,
                            itemBuilder: (BuildContext context, int index) {
                            ///  news[index].sourceName==
                              return DrowAdd(news[index]);
                            },
                            padding: EdgeInsets.all(10),
                            scrollDirection: Axis.vertical,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio: 1.3,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0),
                          ),
                        );
                      }
                      break;
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ));
  }

  Widget drowHeder() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Color(0xff989595),
            size: 35,
          ),
          Expanded(
            child: Text(
              'News App',
              textAlign: TextAlign.center,
              style: GoogleFonts.abrilFatface(
                textStyle: TextStyle(color: Colors.black87, letterSpacing: 0.5),
                fontSize: 28,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget DrowCard(AssetImage assetImage) {
    return Column(
      children: [
        Container(
          height: 160,
          width: 130,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: assetImage,
            ),
          ),
        ),
      ],
    );
  }

  Widget DrowAdd(NewsModel news) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(news),
            ));
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: news.urlToImage != null
                    ? NetworkImage(news.urlToImage)
                    : AssetImage("assets/images/bbc.png"),
              ),
            ),
          ),
          Row(
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
                  news.title.length > 80
                      ? news.title.substring(0, 80)
                      : news.title,
                  textAlign: TextAlign.end,
                  style: GoogleFonts.abrilFatface(
                    textStyle:
                    TextStyle(color: Colors.black87, letterSpacing: 0.5),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
