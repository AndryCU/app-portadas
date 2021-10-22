import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:news_app/model/noticias_model.dart';
import 'package:news_app/model/noticias_provider.dart';
import 'package:news_app/utils/utils.dart';
import 'package:web_scraper/web_scraper.dart';

class ReadNewsView extends StatefulWidget {
 // final Set<Factory> gestureRecognizers = [Factory(() => EagerGestureRecognizer())].toSet();

  final Noticias news=Noticias('Test', 'Decretan estado de alaasdasdsad asdasdasdasdrma en la region occidental ante las fuertes lluvias', 'http://www.cubadebate.cu/noticias/2021/10/20/reapertura-y-flexibilizacion-de-medidas-en-la-habana-que-debe-saber/', 'http://media.cubadebate.cu/wp-content/uploads/2021/10/instituto-periodismo-foto-cesar-gomez-lopez-580x386.jpg', '', 1, 1, 1);
  //ReadNewsView({required this.news});

  @override
  _ReadNewsViewState createState() => _ReadNewsViewState();
}

class _ReadNewsViewState extends State<ReadNewsView> {
  final noticiasP=NoticiasProvider();

  @override
  void initState() {
    noticiasP.writteText(widget.news.url,widget.news.url_image.substring(widget.news.url_image.length-14,widget.news.url_image.length-4));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //noticiasP.read(widget.news.url_image.substring(widget.news.url_image.length-14,widget.news.url_image.length-4));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Center(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      ///si le doy atras y la noticia no es fav, borro el json
                      Navigator.pop(context);
                    },
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.share,color: Colors.blue,),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(widget.news.favorite==1?Icons.favorite_rounded:Icons.favorite_border,color: widget.news.favorite==1?Colors.red:Colors.black,),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal:8.0),
        child: ListView(
          children: [
            SizedBox(height: 2.0),
            Hero(
              tag: widget.news.url,
              child: Container(
                height: MediaQuery.of(context).size.height*0.2,
                width:  MediaQuery.of(context).size.height*0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: getPicture(widget.news.url_image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.0),
           // Text(news.subtitle, style: kTitleCard.copyWith(fontSize: 15.0),textAlign: TextAlign.justify,),
            Container(
              height: MediaQuery.of(context).size.height*0.65,
              width: double.infinity,
              child: FutureBuilder(builder: (context,AsyncSnapshot<String> snapshot) {
                if(snapshot.hasData){
                  final json=jsonDecode(snapshot.data!);
                  return ListView.builder(itemBuilder: (context, index) {
                    if(json['parrafos'][index]['etiqueta']=='p'){
                      return Text('${json['parrafos'][index]['texto']}\n',style: TextStyle(color: Colors.black,fontSize: 15.1),textAlign: TextAlign.justify);
                    }
                    if(json['parrafos'][index]['etiqueta']=='h3'){
                      return Text('${json['parrafos'][index]['texto']}\n',textAlign: TextAlign.left,style: TextStyle(fontSize: 18,color: Colors.blue,),);
                    }
                    if(json['parrafos'][index]['etiqueta']=='blockquote'){
                      return Text('${json['parrafos'][index]['texto']}\n',textAlign: TextAlign.justify,style: TextStyle(fontSize: 14,color: Colors.grey,fontStyle: FontStyle.italic ),);
                    }
                    if(json['parrafos'][index]['etiqueta']=='ul'){
                      for(int i=0;i<json['parrafos'][index]['texto'].length;i++){
                       return Text('\u2022 ${json['parrafos'][index]['texto'][i]['texto']}\n',style: TextStyle(color: Colors.black,fontSize: 15.1),textAlign: TextAlign.justify);
                      }
                    }
                    return Container();
                  },
                    itemCount: json['parrafos'].length,
                  );
                }else{
                  return CircularProgressIndicator();
                }
              },
                future: noticiasP.read(widget.news.url_image.substring(widget.news.url_image.length-14,widget.news.url_image.length-4)),
              )
            ),
            SizedBox(height: 25.0),
          ],
        ),
      ),
    );
  }

  Future<String>test() async{
    final webScraper = WebScraper('http://www.cubadebate.cu');
    if (await webScraper.loadWebPage('/noticias/2021/10/18/los-bravos-lo-hicieron-otra-vez-dodgers-quedan-tendidos-en-el-terreno/')) {
    List<Map<String, dynamic>> elements = webScraper.getElement('div.note_content>p',['text']);
    print(elements.length);
    return elements.toString();
    }
    return '';
  }
}





