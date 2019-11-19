import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatelessWidget {

  final List settingItems = [
    [Icons.favorite, "Your Favorites", (){}],
    [FontAwesomeIcons.wallet, "Wallet", (){}],
    [FontAwesomeIcons.question, "Help", (){}],
    [FontAwesomeIcons.tag, "Promotions", (){}],
  ];

  Widget _buildListItem(IconData icon, String title, Function onTap) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Row(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 20.0),
            child: Icon(icon, size: 25),
          ),
          Text(title, style: TextStyle(color: Colors.black, fontSize: 20))
        ]),
      ),
      onTap: onTap,
    );
  }

  Widget get _settings => Container(
    height: 250,
    color: Colors.white,
    child: ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      itemCount: settingItems.length,
      itemBuilder: (context, int) =>
        _buildListItem(settingItems[int][0], settingItems[int][1], settingItems[int][2]),
      separatorBuilder: (context, int) => Padding(padding: const EdgeInsets.symmetric(vertical: 10.0))
    ),
  );

  Widget get _about => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    height: 50,
    color: Colors.white,
    child: Align(
      alignment: Alignment.centerLeft,
      child:Text("About", style: TextStyle(color: Colors.black, fontSize: 20))
    )
  );

  @override
  Widget build(BuildContext context) {

    final List sections = [
      _settings,
      _about
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container( height: 50,
          child: Row(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Icon(Icons.person_pin, size: 50,),
            ),
            Text("Leon Wu")
          ]),
        ),
      ),
      body: ListView.separated(
        itemCount: sections.length,
        itemBuilder: (ctx, int) => sections[int],
        separatorBuilder: (ctx, int) => Container(
          height: 10.0,
          color: Color(0XFFF2F7FB),
        ),
      )
    );
  }
}