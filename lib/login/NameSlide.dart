import 'package:flutter/material.dart';

class NameSlide extends StatefulWidget {

  final color;

  NameSlide({
    this.color,
    Key key
  });

  @override
  _NameSlideState createState() => _NameSlideState();
}

class _NameSlideState extends State<NameSlide> {
  TextEditingController _textController;
  // int _textLength = 0;
  


  @override
  void initState() {
    _textController = new TextEditingController();
    super.initState();
  }

  void _onTextChanged(String text) {
    setState(() {
      // _textLength = text.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 22.0),
        child: 
        Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(),
            ),
          Expanded(
            flex: 3,
            child: Text("Nice to meet you! What do your friends call you?", 
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
            )),
          ),

          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: TextField(
              onChanged: _onTextChanged,
              maxLength: 32,
              controller: _textController,
              style: TextStyle(color: Colors.white, fontSize: 30),
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                border: InputBorder.none,
                hintText: 'They call me...',
                helperText: "YOUR NICKNAME",
                helperStyle: TextStyle(color: Colors.white, fontSize: 15),
                counterText: "${_textController.text.length} / 32"
              )),
            ),
          ),  
        ]),
      ),
    );
  }
}