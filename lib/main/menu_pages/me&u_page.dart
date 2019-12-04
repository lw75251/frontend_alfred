import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_alfred/custom/scrollable_tab_bar.dart';


enum TabsDemoStyle { iconsAndText, iconsOnly, textOnly }


class _Page {
  final IconData icon;
  final String text;

  final List images;
  final List descriptions;
  final List<double> prices;

  const _Page({
    this.icon, 
    this.text,
    this.images,
    this.descriptions,
    this.prices
  });
}

class MaterialDemoDocumentationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.library_books),
        tooltip: 'API documentation',
        onPressed: () {});
  }
}

class MeAndUScreen extends StatefulWidget {

  @override
  _MeAndUScreenState createState() => _MeAndUScreenState();
}

class _MeAndUScreenState extends State<MeAndUScreen> with SingleTickerProviderStateMixin {
  
  TabController _controller;
  TabsDemoStyle _demoStyle = TabsDemoStyle.textOnly;
  bool _customIndicator = false;
  
  final List<_Page> _allPages = <_Page>[
    _Page(
      icon: Icons.grade, 
      text: 'Entree & Grills',
      images:[
        "http://via.placeholder.com/325x250",
        "http://via.placeholder.com/325x250",
        "http://via.placeholder.com/325x250",
        "http://via.placeholder.com/325x250"
      ],
      descriptions: [
        "Yummy",
        "Great",
        "Beautiful",
        "F",
      ],
      prices: [
        12.10,
        13.75,
        15.2,
        19.18
      ]
    ),
    _Page(
      icon: Icons.playlist_add, 
      text: 'Spicy Salads',
      images:[
        "http://via.placeholder.com/325x250",
        "http://via.placeholder.com/325x250",
        "http://via.placeholder.com/325x250",
        "http://via.placeholder.com/325x250"
      ],
      descriptions: [
        "Yummy",
        "Great",
        "Beautiful",
        "F",
      ],
      prices: [
        12.10,
        13.75,
        15.2,
        19.18
      ]      
    ),
    _Page(
      icon: Icons.check_circle, 
      text: 'A La Carte',
      images:[
        "http://via.placeholder.com/325x250",
        "http://via.placeholder.com/325x250",
        "http://via.placeholder.com/325x250",
        "http://via.placeholder.com/325x250"
      ],
      descriptions: [
        "Yummy",
        "Great",
        "Beautiful",
        "F",
      ],
      prices: [
        12.10,
        13.75,
        15.2,
        19.18
      ]      
    ),
    _Page(
      icon: Icons.question_answer, 
      text: 'Noodles Soups',
      images:[
        "http://via.placeholder.com/325x250",
        "http://via.placeholder.com/325x250",
        "http://via.placeholder.com/325x250",
        "http://via.placeholder.com/325x250"
      ],
      descriptions: [
        "Yummy",
        "Great",
        "Beautiful",
        "F",
      ],
      prices: [
        12.10,
        13.75,
        15.2,
        19.18
      ]      
    ),
  ];

  @override
  void initState() {
     _controller = TabController(vsync: this, length: _allPages.length);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Decoration getIndicator() {
    if (!_customIndicator) return const UnderlineTabIndicator();

    switch (_demoStyle) {
      case TabsDemoStyle.iconsAndText:
        return ShapeDecoration(
          shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                side: BorderSide(
                  color: Colors.white24,
                  width: 2.0,
                ),
              ) +
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                side: BorderSide(
                  color: Colors.transparent,
                  width: 4.0,
                ),
              ),
        );

      case TabsDemoStyle.iconsOnly:
        return ShapeDecoration(
          shape: const CircleBorder(
                side: BorderSide(
                  color: Colors.white24,
                  width: 4.0,
                ),
              ) +
              const CircleBorder(
                side: BorderSide(
                  color: Colors.transparent,
                  width: 4.0,
                ),
              ),
        );

      case TabsDemoStyle.textOnly:
        return ShapeDecoration(
          shape: const StadiumBorder(
                side: BorderSide(
                  color: Colors.white24,
                  width: 2.0,
                ),
              ) +
              const StadiumBorder(
                side: BorderSide(
                  color: Colors.transparent,
                  width: 4.0,
                ),
              ),
        );
    }
    return null;
  }

  void changeDemoStyle(TabsDemoStyle style) {
    setState(() {
      _demoStyle = style;
    });
  }

    Future<List<Widget>> createList() async {
      List<Widget> items = new List<Widget>();
      String dataString =
          await DefaultAssetBundle.of(context).loadString("assets/data.json");
      List<dynamic> dataJSON = jsonDecode(dataString);


      dataJSON.forEach((object) {

        String finalString= "";
        List<dynamic> dataList = object["placeItems"];
        dataList.forEach((item){
          finalString = finalString + item + " | ";
        });

        items.add(Padding(padding: EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 2.0,
                blurRadius: 5.0
              ),
            ]
          ),
          margin: EdgeInsets.all(5.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),bottomLeft: Radius.circular(10.0)),
                child: Image.asset(object["placeImage"],width: 80,height: 80,fit: BoxFit.cover,),
              ),
              SizedBox(
                width: 250,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(object["placeName"]),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0,bottom: 2.0),
                        child: Text(finalString,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12.0,color: Colors.black54,),maxLines: 1,),
                      ),
                      Text("Min. Order: ${object["minOrder"]}",style: TextStyle(fontSize: 12.0,color: Colors.black54),)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),));
      });

      return items;
    }

  @override
  Widget build(BuildContext context) {
    final Color iconColor = Theme.of(context).accentColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Rigos"),
        actions: <Widget>[
//          MaterialDemoDocumentationButton(ScrollableTabsDemo.routeName),
          IconButton(
            icon: const Icon(Icons.sentiment_very_satisfied),
            onPressed: () {
              setState(() {
                _customIndicator = !_customIndicator;
              });
            },
          ),
          PopupMenuButton<TabsDemoStyle>(
            onSelected: changeDemoStyle,
            itemBuilder: (BuildContext context) =>
                <PopupMenuItem<TabsDemoStyle>>[
                  const PopupMenuItem<TabsDemoStyle>(
                      value: TabsDemoStyle.iconsAndText,
                      child: Text('Icons and text')),
                  const PopupMenuItem<TabsDemoStyle>(
                      value: TabsDemoStyle.iconsOnly,
                      child: Text('Icons only')),
                  const PopupMenuItem<TabsDemoStyle>(
                      value: TabsDemoStyle.textOnly, child: Text('Text only')),
                ],
          ),
        ],
        bottom: TabBarNoRipple(
          controller: _controller,
          isScrollable: true,
          indicator: getIndicator(),
          tabs: _allPages.map<Tab>((_Page page) {
            assert(_demoStyle != null);
            switch (_demoStyle) {
              case TabsDemoStyle.iconsAndText:
                return Tab(text: page.text, icon: Icon(page.icon));
              case TabsDemoStyle.iconsOnly:
                return Tab(icon: Icon(page.icon));
              case TabsDemoStyle.textOnly:
                return Tab(text: page.text);
            }
            return null;
          }).toList(),
        ),
      ),
      body: TabBarView(
          controller: _controller,
          children: _allPages.map<Widget>((_Page page) {
            return SafeArea(
              // child: Container(
              //   key: ObjectKey(page.icon),
              //   child: Center(
              //       child: Icon(
              //         page.icon,
              //         color: iconColor,
              //         size: 128.0,
              //         semanticLabel: 'Placeholder for ${page.text} tab',
              //       ),
              //   ),
              // ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: FutureBuilder(
                        initialData: <Widget>[Text("")],
                        future: createList(),
                        builder: (context,snapshot){
                          if(snapshot.hasData){
                            return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: ListView(
                                primary: false,
                                shrinkWrap: true,
                                children: snapshot.data,
                              ),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                    )
                  ],
                ),
              ),


            );
          }).toList()),
    );
  }
}