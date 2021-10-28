
import 'package:flutter/material.dart';
import 'package:news_app/model/noticias_model.dart';
import 'package:news_app/utils/utils.dart';

import '../constants.dart';

class PrimaryCard extends StatelessWidget {
  //link del liading
  //<a target="_blank" href="https://iconos8.es/icon/vET46Sh4TMA0/rhombus-loader">Rhombus Loader</a> icono de <a target="_blank" href="https://iconos8.es">Icons8</a>
  final Noticias news;
  PrimaryCard({required this.news});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: kGrey3, width: 1.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5.0),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  image: getPicture(news.url_image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            news.subtitle,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
            style: kTitleCard,
          ),
        ],
      ),
    );
  }
}
