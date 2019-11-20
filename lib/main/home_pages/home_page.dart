import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:separated_row/separated_row.dart';

import '../../routes/router.dart';

class HomePage extends StatelessWidget {

  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void qrOnTap() {
      var transition = (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
          return Stack(children: <Widget>[
              // TODO: Experiment with Curved Animations
              SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(0.0, 0.0),
                  end: const Offset(-1.0, 0.0),
                ).animate(animation),
                child: this,
              ),
              SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              )
            ],
          );
        };

      router.navigateTo(context, qrRoute,
        transition: TransitionType.custom,
        // transitionBuilder: (context, animation, second, child) => SlideTransition(
        //   position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(animation),
          // child: child));
        transitionDuration: const Duration(milliseconds: 300),
        transitionBuilder: transition,
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          child: Row(children: <Widget>[
            Text("Discovery", style: TextStyle(color: Colors.black, fontSize: 20)),
          ]),
          //TODO: TapDown Make Text become Lighter
          onTapDown: null,
          //TODO: Change Location Page, then update Text
          onTapUp: null,
        ),
        actions: <Widget>[
          IconButton(icon: Icon(FontAwesomeIcons.qrcode), iconSize: 22, onPressed: qrOnTap,)
        ],
      ),
      body: Column(children: <Widget>[
        DiscoveryBlock()
      ]),
    );
  }
}

/// Displays Restaurants near user in CardTiles
class DiscoveryBlock extends StatelessWidget {
  const DiscoveryBlock({Key key}) : super(key: key);

  Widget get _header => Container(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20,15,20,5),
      child: Row(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(Icons.pin_drop, size: 25,),
        ),
        Text("Restaurants Near You", style: TextStyle(color: Colors.black, fontSize: 20),)
      ]),
    )
  );



  Widget _buildCard(String name, String distance) {

    TextStyle nameStyle = TextStyle(color: Colors.black, fontSize: 16);
    TextStyle descriptionStyle = TextStyle(color: Colors.grey, fontSize: 10);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3.0),
      ),
      elevation: 5,
      child: Container(height: 170, width: 200,
        padding: const EdgeInsets.all(5.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(height: 110, width: 180,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3.0),
                child: Image(image: AssetImage('assets/images/placeholder.jpeg'), 
                  fit: BoxFit.fitWidth
                ),
              )
            ),
            Container(height: 50, width: 190,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.5),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                      Text(name, style: nameStyle),
                      RatingBar(
                        itemSize: 16,
                        ignoreGestures: true,
                        initialRating: 3,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.only(right: 2.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ]),
                  ),
                  SeparatedRow(
                    children: <Widget>[
                      Text("\$", style: descriptionStyle,),
                      Text("Breakfast and Brunch", style: descriptionStyle,),
                      Text("American", style: descriptionStyle,),
                      Text(distance, style: descriptionStyle),
                    ],
                    separatorBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: ClipOval(
                          child: Container(
                            color: Colors.grey,
                            height: 3.0, // height of the button
                            width: 3.0, // width of the button
                          ),
                        ),
                      );      
                    }           
                  ),                  
                ]
              )
            )
          ])
    ));
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   height: MediaQuery.of(context).size.height-156,
    //   width: MediaQuery.of(context).size.width,
    //   child: Column(children: <Widget>[
    //     _header,
    //     SizedBox(height: 300,
    //       child: Swiper(
    //         loop: false,
    //         viewportFraction: 0.9,
    //         itemCount: 4,
    //         itemBuilder: (BuildContext context, int index) {
    //           return _buildCard("Los Primos", "6.0 mi");
    //         }
    //       )
    //     )
    //   ]),
    // );
    return _buildCard("Los Primos", "6.0");
    // return SizedBox(
    //   height: 220,
    //   width: 260,
    //   child: ListView( children: <Widget>[
    //     _buildCard("Los Primos", "6.0"),
    //     _buildCard("Los Primos", "6.0"),
    //     _buildCard("Los Primos", "6.0"),
    //     _buildCard("Los Primos", "6.0"),
    //   ],
    //   ),
    // );
  }
}