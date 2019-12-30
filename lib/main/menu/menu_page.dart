import 'dart:convert';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alfred/custom/fluid_nav_bar/fluid_nav_bar.dart';
import 'package:flutter_alfred/custom/scrollable_tab_bar.dart';
import 'package:intl/intl.dart';


enum TabsDemoStyle { iconsAndText, iconsOnly, textOnly }

class _Category {
  final String title;
  final List<_Item> items;

   _Category({
    this.title,
    this.items
  });
}


class _Item {
  final String name;
  final String image;
  final String description;
  final double price;

  const _Item({
    this.name,
    this.image,
    this.description,
    this.price,
  });

  factory _Item.fromJson(Map<String, dynamic> json) {
    return _Item(
      name: json["name"],
      image: json["image"],
      description: json["description"],
      price: json["price"]
    );
  }

}


class MenuScreen extends StatefulWidget {

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {

  TabController _tabController;
  NumberFormat currencyFormat = NumberFormat.currency(
    // locale: "USD"
    symbol: "\$"
  ); 

  @override
  void initState() {
    super.initState();
  }

  Future<List<_Category>> getMenu() async {
    List<_Category> _menu = new List<_Category>();
    String dataString = await DefaultAssetBundle.of(context).loadString("assets/data2.json");
    List<dynamic> _jsonData = jsonDecode(dataString);

    _jsonData.forEach((object) {
      List<dynamic> _itemData = object["items"];
      _Category category = _Category(
        title: object["category"],
        items: _itemData.map<_Item>( 
          (item) => _Item.fromJson(item)
        ).toList()
      );
      _menu.add(category);
    });

    return _menu;
  }

  List<Tab> createTabs(List<_Category> menu) {
    return menu.map<Tab>((category) => Tab(text: category.title)).toList();
  }

  List<Widget> createItems(List<_Category> menu, int index) {
    List<_Item> items = menu[index].items;
    return items.map((item) {
      // return Padding(
      //   padding: EdgeInsets.only(top: 10.0),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: <Widget>[
      //       Container(
      //         child: Row(
      //           children: <Widget>[
      //             Image(
      //               image: AssetImage(item.image),
      //               fit: BoxFit.cover,
      //               height: 75.0,
      //               width: 75.0,
      //             ),
      //             SizedBox(width: 10.0),
      //             Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: <Widget>[
      //                   Text(
      //                     item.name,
      //                     style: TextStyle(
      //                       fontFamily: 'Montserrat',
      //                       fontSize: 17.0,
      //                       fontWeight: FontWeight.bold
      //                     )
      //                   ),
      //                   Text(
      //                     currencyFormat.format(item.price),
      //                     style: TextStyle(
      //                       fontFamily: 'Montserrat',
      //                       fontSize: 15.0,
      //                       color: Colors.grey
      //                     )
      //                   )
      //               ],
      //             )
      //           ],
      //         ),
      //       ),
      //       IconButton(
      //         icon: Icon(Icons.add),
      //         color: Colors.black,
      //         onPressed: () {}
      //       )
      //     ],
      //   ),
      // );
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Row(children: <Widget>[
              Image(
                image: AssetImage(item.image),
                fit: BoxFit.cover,
                height: 75.0,
                width: 75.0,
              ),          
              Flexible(
                child: Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.name,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      Text(
                        currencyFormat.format(item.price),
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15.0,
                          color: Colors.grey
                        )
                      )
                    ],
                  ),
                ),
              ),            
            ]),
          ),
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.black,
            onPressed: () {}
          )
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMenu(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<_Category> menu = snapshot.data;
            _tabController = TabController(vsync: this, length: menu.length);
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                // centerTitle: true,
                backgroundColor: Color(0xFF21BFBD),
                leading: BackButton(color: Colors.white),
                title: Text("Rigos",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.filter_list),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.menu),
                    color: Colors.white,
                    onPressed: () {},
                  )          
                ],
              ),
              backgroundColor: Color(0xFF21BFBD),
              body: Stack(children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      TabBarNoRipple(
                        controller: _tabController,
                        isScrollable: true,
                        labelColor: Color(0xFF21BFBD),
                        unselectedLabelColor: Colors.white,
                        indicator: BubbleTabIndicator(
                          indicatorHeight: 25.0,
                          indicatorColor: Colors.white,
                          tabBarIndicatorSize: TabBarIndicatorSize.tab
                        ),
                        tabs: createTabs(menu)
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
                          child: Container(
                            margin: const EdgeInsets.only(top: 10.0, left: 15.0),
                            padding: const EdgeInsets.only(top: 25.0, left: 30.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0))
                            ),
                            child: TabBarView(
                              controller: _tabController,
                              children: menu.asMap().map<int, Widget>((int i, _Category category) {
                                return MapEntry(i,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                    child: ListView(
                                      primary: false,
                                      shrinkWrap: true,
                                      children: createItems(menu, i),
                                      ),
                                  )
                                );
                              }).values.toList()                            
                            ),
                          ),
                        )
                      ),
                      Container(
                        color: Colors.white,
                        height: 56,
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FluidNavBar(
                    color: Color(0xFF21BFBD),
                  )
                )


                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Container(
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: <Widget>[
                //         Container(
                //           height: 65.0,
                //           width: 60.0,
                //           decoration: BoxDecoration(
                //             border: Border.all(
                //                 color: Colors.grey,
                //                 style: BorderStyle.solid,
                //                 width: 1.0),
                //             borderRadius: BorderRadius.circular(10.0),
                //           ),
                //           child: Center(
                //             child: Icon(Icons.search, color: Colors.black),
                //           ),
                //         ),
                //         Container(
                //           height: 65.0,
                //           width: 60.0,
                //           decoration: BoxDecoration(
                //             border: Border.all(
                //                 color: Colors.grey,
                //                 style: BorderStyle.solid,
                //                 width: 1.0),
                //             borderRadius: BorderRadius.circular(10.0),
                //           ),
                //           child: Center(
                //             child: Icon(Icons.shopping_basket, color: Colors.black),
                //           ),
                //         ),
                //         Container(
                //           height: 65.0,
                //           width: 120.0,
                //           decoration: BoxDecoration(
                //               border: Border.all(
                //                   color: Colors.grey,
                //                   style: BorderStyle.solid,
                //                   width: 1.0),
                //               borderRadius: BorderRadius.circular(10.0),
                //               color: Color(0xFF1C1428)),
                //           child: Center(
                //               child: Text('Checkout',
                //                   style: TextStyle(
                //                       fontFamily: 'Montserrat',
                //                       color: Colors.white,
                //                       fontSize: 15.0))),
                //         )
                //       ],
                //     ),
                //   ),
                // )
              ])          
            );
          } else {
            return CircularProgressIndicator();
          }
        }
    );
      
      //   ListView(
      //   children: <Widget>[
      //     SizedBox(height: 25.0),
      //     Padding(
      //       padding: EdgeInsets.only(left: 40.0),
      //       child: Row(
      //         children: <Widget>[
      //           Text('Healthy',
      //               style: TextStyle(
      //                   fontFamily: 'Montserrat',
      //                   color: Colors.white,
      //                   fontWeight: FontWeight.bold,
      //                   fontSize: 25.0)),
      //           SizedBox(width: 10.0),
      //           Text('Food',
      //               style: TextStyle(
      //                   fontFamily: 'Montserrat',
      //                   color: Colors.white,
      //                   fontSize: 25.0))
      //         ],
      //       ),
      //     ),
      //     SizedBox(height: 40.0),
      //     Container(
      //       height: MediaQuery.of(context).size.height - 185.0,
      //       decoration: BoxDecoration(
      //         color: Colors.white,
      //         borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
      //       ),
      //       child: ListView(
      //         primary: false,
      //         padding: EdgeInsets.only(left: 25.0, right: 20.0),
      //         children: <Widget>[
      //           Padding(
      //               padding: EdgeInsets.only(top: 20.0),
      //               child: Container(
      //                   height: MediaQuery.of(context).size.height - 300.0,
      //                   child: ListView(children: [
      //                     _buildFoodItem('assets/images/plate1.png', 'Salmon bowl', '\$24.00'),
      //                     _buildFoodItem('assets/images/plate2.png', 'Spring bowl', '\$22.00'),
      //                     _buildFoodItem('assets/images/plate6.png', 'Avocado bowl', '\$26.00'),
      //                     _buildFoodItem('assets/images/plate5.png', 'Berry bowl', '\$24.00')
      //                   ]))),
      //         ],
      //       ),
      //     )
      //   ],
      // ),
    // );
  }
}