import 'package:flutter/material.dart';

class NavigationButton extends StatefulWidget {

  final String title;
  final String description;
  final VoidCallback onTap;
  
  const NavigationButton({
    this.title, 
    this.description, 
    this.onTap,
    Key key,
  }) : super(key: key);

  @override
  _NavigationButtonState createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {

  bool active = false;

  void _tapDown( TapDownDetails details ) {
    setState(() {
      active = true;
    });
  }

  void _tapUp( TapUpDetails details ) {
    setState(() {
      active = false;
    });
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {

    TextStyle style = TextStyle(
      color: Colors.black,
      fontFamily: 'Montserrat',
      fontSize: 18
    );
    TextStyle descriptionStyle = TextStyle(
      color: Colors.grey,
      fontFamily: 'Montserrat',
      fontSize: 16
    );  

    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: !active ? Colors.white : Colors.grey,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.title,
                  style: style,
                ),
                Text(widget.description,
                  style: descriptionStyle,
                )
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 18.0,
            )
          ],
        ),
      ),
    );
  }
}