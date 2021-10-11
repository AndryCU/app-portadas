import 'package:flutter/material.dart';
import 'package:news_app/model/noticias_model.dart';
import 'package:news_app/utils/utils.dart';
import 'package:news_app/widgets/circle_button.dart';

import '../constants.dart';

class ReadNewsView extends StatelessWidget {
  final Noticias news;
  ReadNewsView({required this.news});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: Center(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(18.0, 15.0, 18.0, 0),
              child: Row(
                children: [
                  CircleButton(
                    icon: Icons.arrow_back,
                    onTap: () => Navigator.pop(context),
                  ),
                  Spacer(),
                  CircleButton(
                    icon: Icons.share,
                    onTap: () {},
                  ),
                  CircleButton(
                    icon: Icons.favorite_border,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.0),
        child: ListView(
          children: [
            SizedBox(height: 12.0),
            Hero(
              tag: news.url,
              child: Container(
                height: MediaQuery.of(context).size.height*0.37,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: getPicture(news.url_image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Row(
              children: [
                Spacer(),
                Status(
                  icon: Icons.remove_red_eye,
                  total: 'news.seen',
                ),
              ],
            ),
            SizedBox(height: 12.0),
            Text(news.subtitle, style: kTitleCard.copyWith(fontSize: 18.0)),
            SizedBox(height: 15.0),
            Text(
              'news.content',
              style: descriptionStyle,
            ),
            SizedBox(height: 25.0)
          ],
        ),
      ),
    );
  }
}

class Status extends StatelessWidget {
  final IconData icon;
  final String total;
  Status({required this.icon, required this.total});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: kGrey2),
        SizedBox(width: 4.0),
        Text(total, style: kDetailContent),
      ],
    );
  }
}
