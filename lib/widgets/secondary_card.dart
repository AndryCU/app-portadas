import 'package:flutter/material.dart';
import 'package:news_app/model/noticias_model.dart';
import 'package:news_app/utils/utils.dart';

import '../constants.dart';

class SecondaryCard extends StatelessWidget {
  final Noticias news;

  SecondaryCard({required this.news});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: kGrey3, width: 1.0),
      ),
      child: Row(
        children: [
          Container(
            width: size.width*0.2,
            height: size.height*0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                image: getPicture(news.url_image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: kTitleCard,
                  ),
                  SizedBox(height: 4,),
                  Text(
                    news.subtitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: kDetailContent,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
