import 'package:flutter/material.dart';

class TrendingTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      print('en otra pantalla');
      return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: [
        InkWell(
          child: ListTile(title: Text('Cubadebate'),trailing: IconButton(icon: Icon(Icons.keyboard_arrow_right), onPressed: () {
           },),),
          onTap: () {
            Navigator.push(  context,   MaterialPageRoute(
                builder: (context) => Container() //ReadNewsView(news: trending),
            ),  );
          },
        ),
        InkWell(
          child: ListTile(title: Text('RT'),trailing: IconButton(icon: Icon(Icons.keyboard_arrow_right), onPressed: () {
          },),),
          onTap: () {
            Navigator.push(  context,   MaterialPageRoute(
                builder: (context) => Container() //ReadNewsView(news: trending),
            ),  );
          },
        ),
      ],
    );
  }

  //onTap: () {
  //Navigator.push(
  //context,
  //MaterialPageRoute(
  //builder: (context) => Container() //ReadNewsView(news: trending),
  //),
  //);
  //}

}
