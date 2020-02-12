import 'package:flutter/material.dart';
import 'package:flutter_alfred/models/OrderModels.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TipBlock extends StatefulWidget {
  @override
  _TipBlockState createState() => _TipBlockState();
}

class _TipBlockState extends State<TipBlock> {
  var selectedTip = 0.1;
  NumberFormat currencyFormat = NumberFormat.currency(symbol: "\$", decimalDigits: 2);
  NumberFormat percentageFormat = NumberFormat.decimalPercentPattern(decimalDigits: 0);
  
  Widget _buildInfoCard(double tip) {
    final orderSummary = Provider.of<OrderSummary>(context);
    void selectCard(tip) {
      setState(() {
        selectedTip = tip;
      });
      orderSummary.tip = tip;
    }    

    return InkWell(
      onTap: () => selectCard(tip),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: tip == selectedTip ? Color(0xFF7A9BEE) : Colors.white,
          border: Border.all(
            color: tip == selectedTip ? 
            Colors.transparent :
            Colors.grey.withOpacity(0.3),
            style: BorderStyle.solid,
          width: 0.75
          ),
          
        ),
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
                color: tip == selectedTip
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.bold
              )            

            ),
            Text(currencyFormat.format(orderSummary.ordertotal*tip),
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12.0,
                color:
                    tip == selectedTip ? Colors.white : Colors.grey.withOpacity(0.7),
              )
            ),
          ]
        )
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Tip"),
          Container(
            height: 70.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                  _buildInfoCard(.1),
                  SizedBox(width: 10.0),
                  _buildInfoCard(.15),
                  SizedBox(width: 10.0),
                  _buildInfoCard(.2),
                  // SizedBox(width: 10.0),
                  // _buildInfoCard(0),
              ],
            )
          ),
        ],
      ),
    );
  }
}