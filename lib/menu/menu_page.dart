import 'dart:convert';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alfred/custom/scrollable_tab_bar.dart';
import 'package:flutter_alfred/models/MenuModels.dart';
import 'package:flutter_alfred/models/OrderModels.dart';
import 'package:flutter_alfred/models/RestaurantModel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


enum TabsDemoStyle { iconsAndText, iconsOnly, textOnly }

class MenuScreen extends StatefulWidget {

  const MenuScreen({Key key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {

  Future<List<Category>> _menu;
  TabController _tabController;
  NumberFormat currencyFormat = NumberFormat.currency(symbol: "\$");
  String test = ""; 

  @override
  void initState() {
    // _menu = Future.value(getMenu());
    // _menu = Future.value(restaurant.getMenu());
    super.initState();
  }

  Future<List<Category>> getMenu() async {
    List<Category> _menu = new List<Category>();
    String dataString = await DefaultAssetBundle.of(context).loadString("assets/data2.json");
    List<dynamic> _jsonData = jsonDecode(dataString);

    _jsonData.forEach((object) {
      List<dynamic> itemData = object["items"];
      Category category = Category(
        title: object["category"],
        items: itemData.map<Item>( 
          (item) => Item.fromJson(item, object["category"])
        ).toList()
      );
      _menu.add(category);
    });

    return _menu;
  }

  List<Tab> createTabs(List<Category> menu) {
    return menu.map<Tab>((category) => Tab(text: category.title)).toList();
  }

  List<Widget> createItems(List<Category> menu, int index) {
    final orderSummary = Provider.of<OrderSummary>(context);
    List<Item> items = menu[index].items;
    return items.map((item) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Row(children: <Widget>[
              SizedBox(
                child: Image(
                  image: NetworkImage("https://alfredexpresstest.s3.amazonaws.com/food_images/${item.image}"),
                ),
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
            onPressed: () {
              orderSummary.addItem(
                ItemSummary.fromItem(item, 1)
              );
            }
          )
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Color _textColor = Colors.white;
    final orderSummary = Provider.of<OrderSummary>(context);
    final restaurant = Provider.of<Restaurant>(context);

    // return Scaffold(
    //   body: Center(
    //     child: MaterialButton(
    //       color: Colors.blue,
    //       child: Text(test),
    //       onPressed: () async {
    //         await restaurant.getMenu();
    //       },
    //     ),
    //   ),
    // );


    return FutureBuilder(
        // future: _menu,
        future: restaurant.getMenu(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Category> menu = snapshot.data;
            _tabController = TabController(
              vsync: this, 
              length: menu.length,
            );
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                // centerTitle: true,
                backgroundColor: Color(0xFF21BFBD),
                leading: BackButton(color: _textColor),
                title: Text("Rigos",
                  style: TextStyle(
                    color: _textColor,
                    fontSize: 22.0
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.filter_list),
                    color: _textColor,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    color: _textColor,
                    onPressed: () {
                      orderSummary.printOrder();
                    },
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
                        unselectedLabelColor: _textColor,
                        indicator: BubbleTabIndicator(
                          indicatorHeight: 25.0,
                          indicatorColor: Colors.white,
                          tabBarIndicatorSize: TabBarIndicatorSize.tab
                        ),
                        tabs: createTabs(menu)
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          padding: const EdgeInsets.only(top: 25.0, left: 30.0, right: 30.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(75.0),
                              topRight: Radius.circular(75.0)
                              )

                          ),
                          child: TabBarView(
                            controller: _tabController,
                            children: menu.asMap().map<int, Widget>((int i, Category category) {
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
                      ),
                      Container(
                        height: 56.0,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: FluidNavBar(
                //     color: Color(0xFF21BFBD),
                //   )
                // )
              ])          
            );
          } else {
            return CircularProgressIndicator();
          }
        }
    );
  }
}