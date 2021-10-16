import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/ConnectionStatus.dart';
import 'package:news_app/model/db.dart';
import 'package:news_app/model/noticias_model.dart';
import 'package:news_app/model/noticias_provider.dart';
import 'package:news_app/utils/preferences.dart';
import 'package:news_app/views/read_news_view.dart';
import 'package:news_app/widgets/primary_card.dart';
import 'package:news_app/widgets/secondary_card.dart';
import 'package:provider/provider.dart';

import '../constants.dart';


class PopularTabView extends StatefulWidget {
  @override
  _PopularTabViewState createState() => _PopularTabViewState();
}

class _PopularTabViewState extends State<PopularTabView> {

  late Future<List<Noticias>> destacadas;
  final noticiasProvider=NoticiasProvider();
  late Future<List<Noticias>> futuro_principal;
  final prefs = new PreferenciasUsuario();
  @override
  void initState() {
    destacadas=noticiasProvider.getDestacadas();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print('build popular tab');
    return Container(
      child: ListView(
        physics: ScrollPhysics(),
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height*0.45,
            padding: EdgeInsets.only(left: 18.0),
            child: FutureBuilder(
              future: DBProvider.db.getNoticiasPortada(context),
              builder: (context,AsyncSnapshot<List<Noticias>> snapshot) {
                if(snapshot.hasData&&snapshot.data!.length==0){
                  return PrimaryCard(news: Noticias('Cargando','','','assets/cargando-loading-043.gif','',-1,-1));
                }
                if (snapshot.hasData){
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
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
              if(snapshot2.hasData){
                return ListView.builder(
                  itemCount: snapshot2.data!.length,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
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

  Future<List<Noticias>> _refresh()async {
    destacadas=NoticiasProvider().getDestacadas();
    print('ejecuta refresh');
    return destacadas;
  }
}
