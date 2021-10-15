import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'db.dart';
import 'noticias_model.dart';

class NoticiasProvider{
  //OBTENGO LAS NOTICIAS QUE VAN EN LA LISTA HORIZONTAL
  principalesNews()async{
    print('EJECUTA principalesNews');
    String url_picture='';
    String tittle='';
    String url='';
    List<Noticias> noticias_principal_portada = [];
    bool flag=false;
    final response_todas_las_noticias =await http.Client().get(Uri.parse("https://actualidad.rt.com/todas_las_noticias"));
    final response_viral =await http.Client().get(Uri.parse("https://actualidad.rt.com/viral"));

    var viral=parser.parse(response_viral.body);
    var todas_las_noticias=parser.parse(response_todas_las_noticias.body);

    if (response_viral.statusCode==200){
      //VIRAL//
      String subtittle=viral.getElementsByClassName('Link-root Link-isFullCard')[0].text.trim();
      String url_image='';
      try{
        int as=viral.getElementsByClassName('Card-root Card-isHoverScale')[0]
            .children[1].attributes['class']!.length;
      }catch (e){
        flag=true;
      }

      if(flag){
        url_image='assets/foto-no-disponible.jpg';
      }else{
        url_image=viral.getElementsByClassName('Card-picture')[0]
            .children[0]
            .children[2]
            .attributes['data-src']!.trim();
      }
      //DESCARGAR
      if(url_image.contains('http')){
        url_image=await downloadAndPath(url_image);
      }
      flag=false;
      String url2=viral.getElementsByClassName('Link-root Link-isFullCard')[0].attributes['href'].toString();
      await DBProvider.db.addNoticiaPortada(Noticias('VIRAL', subtittle, 'https://actualidad.rt.com$url2', url_image, '', -1, 1));
      //noticias_principal_portada.add(Noticias('VIRAL', subtittle, 'https://actualidad.rt.com$url2', url_image.toString(),'',-1,-1));
      //VIRAL
      for (int a=0;a<4;a++){
        //NOTICIAS//////////
        try{
          String as=todas_las_noticias.getElementsByClassName('Card-root Card-isHoverScale')[a]
              .children[1].attributes['class']!.toString();
        }catch (e){
          flag=true;
        }

        if(flag){
          url_picture='assets/foto-no-disponible.jpg';
        }else{
          url_picture=todas_las_noticias.getElementsByClassName('Card-root Card-isHoverScale')[a]
              .children[0]
              .children[0]
              .children[0]
              .children[2]
              .attributes['data-src']!.trim();
        }
        tittle=todas_las_noticias.getElementsByClassName('Link-root Link-isFullCard')[a].text.trim();
        url=todas_las_noticias.getElementsByClassName('Link-root Link-isFullCard')[a].attributes['href']!.trim();

        if(url_picture.contains('http')){
          url_picture=await downloadAndPath(url_picture);
        }
        flag=false;
        print(tittle);
        await DBProvider.db.addNoticiaPortada(Noticias('',tittle , 'https://actualidad.rt.com/$url', url_picture.toString(),'',-1,1));
        // noticias_principal_portada.add(Noticias('',tittle , 'https://actualidad.rt.com/$url', url_picture.toString(),'',-1,1));

      }
    }
    //return  noticias_principal_portada;
  }

  Future<List<Noticias>> getDestacadas()async{


    List<Noticias> noticias_destacada = [];
   
    //CUBADEBATE//
    final response_cubadebate =await http.Client().get(Uri.parse("http://www.cubadebate.cu/"));
    var web_cubadebate=parser.parse(response_cubadebate.body);
    
    //CUBADEBATE//


    //RT//
    final response =await http.Client().get(Uri.parse("https://actualidad.rt.com/viral"));
    var web=parser.parse(response.body);
    for(var i=0;i<4;i++){
      final noticia=web_cubadebate.getElementById('front-list')!.children[i];

      String url_cubadebate=noticia.getElementsByClassName('title')[0].children[0].attributes['href']!.trim();
      String tittle_cubadebate=noticia.getElementsByClassName('title')[0].children[0].text.trim();
      String subtittle_cubadebate='';

      try {
        subtittle_cubadebate=noticia.getElementsByClassName('excerpt')[0].children[0].text.trim();
      }catch(e){

      }

      String url_picture_cubadebate=noticia.getElementsByClassName('spoiler')[0].children[0].children[0].attributes['src']!.trim();
      noticias_destacada.add(Noticias(tittle_cubadebate, subtittle_cubadebate, url_cubadebate.toString(), url_picture_cubadebate.toString(),'',-1,1));
    }
    String url=web.getElementsByClassName('Section-container Section-isRow-isTop-isWrap')[1]
        .children[0]
        .children[0]
        .children[0]
        .children[0]
        .children[0]
        .children[0]
        .children[0]
        .attributes['href'].toString();
    final response2 =await http.Client().get(Uri.parse('https://actualidad.rt.com$url'));
    var web2=parser.parse(response2.body);
    String tittle=web2.getElementsByClassName('HeadLine-root HeadLine-type_2 ')[0].text.trim();
    String url_image=web2.getElementsByClassName('Cover-image')[0]
        .children[0]
        .children[2]
        .attributes['data-src']
        .toString();
    String subtittle=web2.getElementsByClassName('ArticleView-summary')[0]
        .children[0]
        .text
        .trim();
    noticias_destacada.add(Noticias(tittle, subtittle, url.toString(), url_image.toString(),'',-1,1));
    return noticias_destacada;
  }

  Future<String> downloadAndPath(String url) async{
    final directory=await getApplicationDocumentsDirectory();
    final String ext=url.contains('.jpeg')?'.jpeg':'.jpg';
    final String nombre='';

    final path='${directory.path}/imagenes_descargadas/${url.substring(url.length-14,url.length-4).toString()}.jpg';
    final foto=File(path);
        final response=await Dio().get(url,
        options: Options(
            responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0
        )
        );

        final raf=foto.openSync(mode: FileMode.write);
        raf.writeFromSync(response.data);
        await raf.close();
        return foto.path;
    }
}










