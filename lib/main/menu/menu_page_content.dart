import 'dart:convert';

import 'package:flutter/material.dart';

class MenuPageContent extends StatelessWidget {
  const MenuPageContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    Future<List<Widget>> createList() async {
      List<Widget> items = new List<Widget>();
      String dataString = await DefaultAssetBundle.of(context).loadString("assets/data.json");
      print(dataString);
      List<dynamic> dataJson = jsonDecode(dataString);

      dataJson.forEach((object) {
        items.add(
          Padding(
            padding: EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 2.0,
                    blurRadius: 5.0
                  )
                ]
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
                    child: Image.asset(object["placeImage"], 
                      width: 80, height: 80, 
                      fit: BoxFit.cover,
                    ),
                  )
                ]
              )
            )
          )
        );
      });
      
      return items;

    }

    return SliverFillRemaining(
      child: Container(
        child: FutureBuilder(
          initialData: <Widget>[Text("")],
          future: createList(),
          builder: (context, snapshot) {
            if( snapshot.hasData ) {
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
          },
        ),
      ),
    );
    

  }
}