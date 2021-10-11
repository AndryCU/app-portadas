import 'package:flutter/material.dart';
import 'package:news_app/model/db.dart';
import 'package:news_app/model/noticias_model.dart';
import 'package:news_app/model/noticias_provider.dart';
import 'package:news_app/utils/preferences.dart';
import 'package:news_app/views/read_news_view.dart';
import 'package:news_app/widgets/primary_card.dart';
import 'package:news_app/widgets/secondary_card.dart';

import '../constants.dart';


class PopularTabView extends StatefulWidget {
  @override
  _PopularTabViewState createState() => _PopularTabViewState();
}

class _PopularTabViewState extends State<PopularTabView> {
  late Future<List<Noticias>> principales;
  late Future<List<Noticias>> destacadas;
  final prefs = new PreferenciasUsuario();
  @override
  void initState() {
    principales=NoticiasProvider().principalesNews();
    destacadas=NoticiasProvider().getDestacadas();
    DBProvider.db.addNoticiaPortada(Noticias('', '_subtitle', '_url', '_url_image', '_content', 1, 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 300.0,
            padding: EdgeInsets.only(left: 18.0),
            child: FutureBuilder(
              future: principales,
              builder: (context,AsyncSnapshot<List<Noticias>> snapshot) {
                if (snapshot.hasData){
                  print('se ejecuta');
                  return ListView.builder(
                    physics: ScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReadNewsView(news: snapshot.data![index]),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 12.0),
                          child:  PrimaryCard(news: snapshot.data![index]),
                        ),
                      );
                    },
                  );
                }
                return PrimaryCard(news: Noticias('Cargando','','','assets/cargando-loading-043.gif','',-1,-1));
              },
            ),
          ),
          SizedBox(height: 25.0),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 19.0),
              child: Text("Destacadas",
                  style: kNonActiveTabStyle),
            ),
          ),
          FutureBuilder(
            future: destacadas,
            builder: (context, AsyncSnapshot<List<Noticias>> snapshot2) {
             // print(snapshot2.data!.length);
              if(snapshot2.hasData){
                return ListView.builder(
                  itemCount: snapshot2.data!.length,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index2) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Container() //ReadNewsView(news: recent),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height*0.2,
                        margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                        child: SecondaryCard(news: snapshot2.data![index2]),
                      ),
                    );
                  },
                );
              }else{
                return SecondaryCard(news: Noticias('Cargando','','','assets/cargando-loading-043.gif','',-1,-1),);
              }
            },
          )
        ],
      ),
    );
  }
}
