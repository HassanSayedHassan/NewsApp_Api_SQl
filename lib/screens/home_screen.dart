import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tell_me/models/news.dart';
import 'package:tell_me/screens/details_screen.dart';
import 'package:tell_me/screens/filter_screen.dart';
import 'package:tell_me/services/news_api.dart';
import 'package:tell_me/services/sqflite.dart';
import 'package:tell_me/widgets/api_handlar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NewsModel> newsModels = [];
  List<AssetImage> assetImage = [
    AssetImage("assets/images/bbc.png"),
    AssetImage("assets/images/masrawy.png"),
    AssetImage("assets/images/youm.jpg")
  ];
  List<String> sourceNames = [
    "BBC News",
    "Masrawy.com",
    "Youm7.com",
  ];

  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    NewsModel newsModels=NewsModel(
      url: '2112',
      title: "21",
      description: "21",
      urlToImage: "321312",
      publishedAt: "#12",
      sourceName: "sourceName",
    );
    NewsModel newss=NewsModel(
      url: '2112',
      title: "21",
      description: "21",
      urlToImage: "321312",
      publishedAt: "#12",
      sourceName: "#12",
    );
  await MySql().update(newss,newsModels);
    MySql().getData().then((value) {
      print(value.length);
     value.forEach((element) {
       print("nammmmm ${element.sourceName}");
     });
    });
 //   MySql().delete(12);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          drowHeder(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Popular ',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.abrilFatface(
                    textStyle:
                        TextStyle(color: Colors.black87, letterSpacing: 0.5),
                    fontSize: 22,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 180,
            child: GridView.builder(
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return DrowCard(assetImage[index], sourceNames[index]);
              },
              padding: EdgeInsets.all(10),
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Top News ',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.abrilFatface(
                    textStyle:
                        TextStyle(color: Colors.black87, letterSpacing: 0.5),
                    fontSize: 22,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: NewsApi().fetChNews(),
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

  Widget DrowCard(AssetImage assetImage, sourceName) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FilterScreen(sourceName),
            ));
      },
      child: Column(
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
      ),
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
