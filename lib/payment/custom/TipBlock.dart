import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_alfred/models/OrderModels.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TipBlock extends StatefulWidget {
  @override
  _TipBlockState createState() => _TipBlockState();
}

class _TipBlockState extends State<TipBlock> {
  String selectedTip = "10%";
  NumberFormat currencyFormat = NumberFormat.currency(symbol: "\$", decimalDigits: 2);
  NumberFormat percentageFormat = NumberFormat.decimalPercentPattern(decimalDigits: 0);
  final _textController = TextEditingController();

  @override
  void initState() { 
    _textController.addListener(() {
      final percentage = int.parse(_textController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderSummary = Provider.of<OrderSummary>(context);

    void setTip(double tip) => orderSummary.tip = tip;
    double getTip() => orderSummary.tip;
    void selectCard(String tipString, double tip) {
      setState(() { selectedTip = tipString; });
      setTip(tip);  
    }  

  Widget tipCard(String tipString, double tip) =>
    InkWell(
      onTap: () => selectCard(tipString, tip),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: tipString == selectedTip ? Color(0xFF7A9BEE) : Colors.white, 
          border: Border.all(
            color: tipString == selectedTip ? 
            Colors.transparent :
            Colors.grey.withOpacity(0.3),
            style: BorderStyle.solid,
            width: 0.75
          )),
        height: 50.0,
        width: 75.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(percentageFormat.format(tip),
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14.0,
                color: tipString == selectedTip
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.bold
            )),
            Text(currencyFormat.format(tip * orderSummary.ordertotal),
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12.0,
                color: tipString == selectedTip ? Colors.white : Colors.grey.withOpacity(0.7),
              )),
          ])
    ));  

  Widget customTipCard() => 
    InkWell(
      onTap: () => selectCard("Custom", 0.2),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: "Custom" == selectedTip ? Color(0xFF7A9BEE) : Colors.white,
          border: Border.all(
            color: "Custom" == selectedTip ? 
            Colors.transparent :
            Colors.grey.withOpacity(0.3),
            style: BorderStyle.solid,
            width: 0.75
          )),
        height: 50.0,
        width: 75.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Custom",
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14.0,
                color: "Custom" == selectedTip
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.bold
            )),
            TextField(
              controller: _textController,
              keyboardType: TextInputType.number,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
            ),
            Text(currencyFormat.format(getTip()),
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12.0,
                color: "Custom" == selectedTip ? Colors.white : Colors.grey.withOpacity(0.7),
            )),
          ])
    ));

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Tip"),
          Container(
            height: 50.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                  tipCard("10%", 0.1),
                  SizedBox(width: 10.0),
                  tipCard("15%", 0.15),
                  SizedBox(width: 10.0),
                  tipCard("18%", 0.18),
                  SizedBox(width: 10.0),
                  customTipCard(),
              ],
            )
          ),
        ],
      ),
    );
  }
}