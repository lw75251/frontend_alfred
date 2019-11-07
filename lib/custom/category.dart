import 'package:flutter/material.dart';
import 'package:flutter_alfred/routes/router.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        router.navigateTo(context, menuRoute, 
          transitionDuration: const Duration(milliseconds: 200));
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: const Text('Category'),
        color: Colors.teal[200],
      ),
    );
  }
}