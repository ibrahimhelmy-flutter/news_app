import 'package:flutter/material.dart';

class CategoryItemBuild extends StatelessWidget {
  const CategoryItemBuild({Key key, this.cat}) : super(key: key);

  final String cat;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.network(
            "https://images.unsplash.com/32/Mc8kW4x9Q3aRR3RkP5Im_IMG_4417.jpg?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YmFja2dyb3VuZHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
            width: 130,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.25),
              borderRadius: BorderRadius.all(Radius.circular(45))),
          child: Text(
            cat,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
