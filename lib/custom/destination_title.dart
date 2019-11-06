
import 'package:flutter/material.dart';

enum ViewState {
  enlarge, // Hero to play enlarging animation
  enlarged, // Hero is static and enlarged
  shrink, // Hero to play shrinking animation
  shrunk, // Hero is static and shrunk
}

/// A function that lets [Hero]es self supply a [Widget] that is shown during the
/// hero's flight from one route to another instead of default (which is to
/// show the destination route's instance of the Hero).
class DestinationTitle extends StatefulWidget {
  final String title;
  final ViewState viewState;
  final double smallFontSize;
  final double largeFontSize;
  final int maxLines;
  final TextOverflow textOverflow;
  final bool isOverflow;

  const DestinationTitle({
    Key key,
    @required this.title,
    @required this.viewState,
    
    // Extra parameters if you want to exert more controls on your Text widget
    this.smallFontSize = 20.0,
    this.largeFontSize = 48.0,
    this.maxLines = 2,
    this.textOverflow = TextOverflow.ellipsis,
    this.isOverflow = false,
  }) : super(key: key);

  @override
  _DestinationTitleState createState() => _DestinationTitleState();
}

class _DestinationTitleState extends State<DestinationTitle>
    with SingleTickerProviderStateMixin {
    
  AnimationController _animationController;
  Animation<double> _fontSizeTween;
  double fontSize;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 330),
    )..addListener(() {
        setState(() {
          fontSize = _fontSizeTween.value;
        });
      });
      
    // Defines the logic according to ViewState
    switch (widget.viewState) {
     
      // Play enlarging animation when receive command
      case ViewState.enlarge:
        _fontSizeTween = Tween<double>(
          begin: widget.smallFontSize,
          end: widget.largeFontSize,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
        _animationController.forward(from: 0.0);
        break;

      // Widget is enlarged, static with large font size
      case ViewState.enlarged:
        fontSize = widget.largeFontSize;
        break;
     
      // Play shrinking animation when receive command 
      case ViewState.shrink:
        _fontSizeTween = Tween<double>(
          begin: widget.largeFontSize,
          end: widget.smallFontSize,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
        _animationController.forward(from: 0.0);
        break;

      // Widget is shrunk, static with small font size
      case ViewState.shrunk:
        fontSize = widget.smallFontSize;
        break;
    }
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    
    // Just a stateless Text widget with font size as parameter
    return 
    FittedBox(
      fit: BoxFit.none,
      alignment: Alignment.centerLeft,
      child: 
      Text( widget.title,
        style: TextStyle(
          fontFamily: 'Varela',
          fontWeight: FontWeight.w500,
          fontSize: fontSize,
          color: Colors.black
        ),
        maxLines: widget.maxLines,
        overflow: widget.textOverflow,
      ),
    );

    
  }
}