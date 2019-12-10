import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_alfred/custom/scrollable_tab_bar.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter_alfred/main/menu/custom/sliding_panel.dart';
import 'package:flutter_alfred/routes/router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';




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

class MeAndUScreen extends StatefulWidget {

  @override
  _MeAndUScreenState createState() => _MeAndUScreenState();
}

class _MeAndUScreenState extends State<MeAndUScreen> with SingleTickerProviderStateMixin {
  
  TabController _tabController;
  bool _start = false;
  bool _return = false;

  TabsDemoStyle _demoStyle = TabsDemoStyle.textOnly;
  bool _customIndicator = true;
  
  final List<_Page> _allPages = <_Page>[
    _Page( icon: Icons.grade, text: 'Entree & Grills',),
    _Page( icon: Icons.playlist_add, text: 'Spicy Salads',),
    _Page( icon: Icons.check_circle, text: 'A La Carte',  ),
    _Page( icon: Icons.question_answer, text: 'Noodles Soups',   ),
  ];

  @override
  void initState() {
     _tabController = TabController(vsync: this, length: _allPages.length);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
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
                  color: Colors.white54,
                  width: 3.0,
                ),
              ) +
              const StadiumBorder(
                side: BorderSide(
                  color: Colors.white12,
                  width: 4.0,
                ),
              ),
        );
    }
    return null;
  }

  // void changeDemoStyle(TabsDemoStyle style) {
  //   setState(() {
  //     _demoStyle = style;
  //   });
  // }

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
              child: Image.asset(object["placeImage"],width: 80,height: 100,fit: BoxFit.cover,),
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
                    Text("sfjaojfaiwoefjaowjfwapifjapwifjawifp"),
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

  void navigateToItem(TapUpDetails details) {
    router.navigateTo(context, checkoutRoute, 
      transitionDuration: const Duration(milliseconds: 200));
  }

  Widget _header() {


    final statusBar = MediaQuery.of(context).padding.top;
    final duration = const Duration(milliseconds: 300);
    final tween = MultiTrackTween([
      Track("height").add( duration, Tween(
        begin: 50.0, end: MediaQuery.of(context).size.height)),
      Track("ani").add( duration, Tween(begin: 0.0, end: 1.0)),
      Track("padding").add( duration, Tween(begin: 15.0, end: statusBar + 8.0)),
      Track("opacity").add( duration, Tween(begin: 1.0, end: 0.0))
    ]);

    Playback getPlayback() {
      if (!_return) {
        return !_start ? Playback.PAUSE : Playback.PLAY_FORWARD; 
      } else {
        return Playback.PLAY_REVERSE;
      }
    }

    void _startAnimation() {
      setState(() {
        _return = false;
        _start = true;
      });
    } 

    void _listenToAnimationFinished(status) async {
      if ( !_return ) {
        if (status == AnimationStatus.completed) {
          final result = await Navigator.pushNamed(context, checkoutRoute);
          setState(() {
            _return = result;
            _start = false;
          });
        }
      } 
   }

    return GestureDetector(
      onTap: _startAnimation,
      child: ControlledAnimation(
        playback: getPlayback(),
        tween: tween,
        duration: tween.duration,
        animationControllerStatusListener: _listenToAnimationFinished,
        builder: (ctx, ani) => Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0 * (1-ani["ani"])), 
              topRight: Radius.circular(20.0 * (1-ani["ani"]))
            )
          ),
          width: MediaQuery.of(context).size.width,
          height: ani["height"],
          child: Align(
            alignment: Alignment.topCenter,
              child: Padding(
              padding: EdgeInsets.only(top: ani["padding"],),
              child: Opacity(
                opacity: ani["opacity"],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              FontAwesomeIcons.shoppingCart,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          Text( "View Cart",
                            style: TextStyle(color: Colors.white),
                          ),  
                      ]),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            "2 Items | Subtotal: \$9.50",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),       
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    // return Container(
    //   decoration: BoxDecoration(
    //     color: Colors.black,
    //     borderRadius: BorderRadius.only(
    //       topLeft: Radius.circular(20.0), 
    //       topRight: Radius.circular(20.0)
    //     )
    //   ),
    //   width: MediaQuery.of(context).size.width,
    //   height: 50.0,
    //   child: Padding(
    //     padding: const EdgeInsets.only(top: 5.0,),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: <Widget>[
    //         Flexible(
    //           flex: 2,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: <Widget>[
    //               Padding(
    //                 padding: const EdgeInsets.only(right: 8.0),
    //                 child: Icon(
    //                   FontAwesomeIcons.shoppingCart,
    //                   size: 18,
    //                   color: Colors.white,
    //                 ),
    //               ),
    //               Text( "View Cart",
    //                 style: TextStyle(color: Colors.white),
    //               ),  
    //           ]),
    //         ),
    //         Flexible(
    //           fit: FlexFit.tight,
    //           flex: 3,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: <Widget>[
    //               SizedBox(
    //                 width: 4.0,
    //               ),
    //               Text(
    //                 "2 Items | Subtotal: \$9.50",
    //                 style: TextStyle(color: Colors.white),
    //               ),
    //             ],
    //           ),
    //         ),       
    //       ],
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final Color iconColor = Theme.of(context).accentColor;
    final _screenHeight = MediaQuery.of(context).size.height;
    final _screenWidth = MediaQuery.of(context).size.width;

    var style = TextStyle(
      color: Colors.white
    );

    return Material(
      child: Stack(children: <Widget>[
        Scaffold(
          appBar: AppBar(
            leading: BackButton(color: Colors.white,),
            backgroundColor: Colors.black,
            title: Text("Rigos", style: style),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.sentiment_very_satisfied),
                onPressed: () {
                  setState(() {
                    _customIndicator = !_customIndicator;
                  });
                },
              ),
            ],
            bottom: TabBarNoRipple(
              controller: _tabController,
              isScrollable: true,
              // indicator: getIndicator(),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.white,
              indicator: BubbleTabIndicator(
                indicatorHeight: 25.0,
                indicatorColor: Colors.white,
                tabBarIndicatorSize: TabBarIndicatorSize.tab
              ),
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
            controller: _tabController,
            children: _allPages.map<Widget>((_Page page) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        color: Colors.white,
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
            }).toList()
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _header()
        )
      ]),
    ); 
    

  }
}

