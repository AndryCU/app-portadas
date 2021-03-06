
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:news_app/model/db.dart';
import 'package:news_app/model/noticias_model.dart';
import 'package:news_app/utils/preferences.dart';
class ReadNewsView extends StatefulWidget {
  late final Noticias news;//=Noticias('Test', 'Decretan estado de alaasdasdsad asdasdasdasdrma en la region occidental ante las fuertes lluvias', 'http://www.cubadebate.cu/noticias/2021/10/20/reapertura-y-flexibilizacion-de-medidas-en-la-habana-que-debe-saber/', 'http://media.cubadebate.cu/wp-content/uploads/2021/10/instituto-periodismo-foto-cesar-gomez-lopez-580x386.jpg', '', 1, 1, 1);
  ReadNewsView({required this.news});

  @override
  _ReadNewsViewState createState() => _ReadNewsViewState();
}

class _ReadNewsViewState extends State<ReadNewsView> {  
  final prefs=PreferenciasUsuario();
  InAppWebViewController? webViewController;
  final GlobalKey webViewKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: Center(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.share,color: Colors.blue,),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(widget.news.favorite==1?Icons.favorite:Icons.favorite_border,color: widget.news.favorite==1? Colors.red:Colors.black,),
                    onPressed: () {
                      setState(() {
                        
                      });
                      DBProvider.db.addNoticiaFavoritoActualizandoValor(widget.news);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        //height: MediaQuery.of(context).size.width*0.65,
        //padding: EdgeInsets.symmetric(horizontal:4.0),
        child: InAppWebView(
          key: webViewKey,
          onWebViewCreated: (controller) {
            webViewController = controller;
            webViewController!.loadUrl(urlRequest: URLRequest(url: Uri.parse(widget.news.url)));
          },
          initialOptions: options(),
        )
      ),
    );
  }

 InAppWebViewGroupOptions options(){
   InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      android: AndroidInAppWebViewOptions(
        loadsImagesAutomatically: prefs.loadImage,        
      )
      );
      return options;
  }
}





