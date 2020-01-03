import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
      },
      child: Container(
        height: 100, width: 150,
        padding: const EdgeInsets.all(8),
        child: const Text('Category'),
        color: Colors.teal[200],
      ),
    );
  }
}