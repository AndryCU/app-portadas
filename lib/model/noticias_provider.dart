import 'dart:async';

import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'noticias_model.dart';

class NoticiasProvider{

  //OBTENGO LAS NOTICIAS QUE VAN EN LA LISTA HORIZONTAL
  Future<List<Noticias>> principalesNews()async{
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
      flag=false;
      String url2=viral.getElementsByClassName('Link-root Link-isFullCard')[0].attributes['href'].toString();
      noticias_principal_portada.add(Noticias('VIRAL', subtittle, 'https://actualidad.rt.com$url2', url_image,'',-1,-1));
      //VIRAL
      for (int a=0;a<4;a++){
        //NOTICIAS//////////
        try{
          int as=todas_las_noticias.getElementsByClassName('Card-root Card-isHoverScale')[a]
              .children[1].attributes['class']!.length;
        }catch (e){
          flag=true;
        }

        if(flag){
          url_picture='assets/foto-no-disponible.jpg';
        }else{
          url_picture=todas_las_noticias.getElementsByClassName('Card-picture')[a]
              .children[0]
              .children[2]
              .attributes['data-src']!.trim();
        }
        flag=false;
        tittle=todas_las_noticias.getElementsByClassName('Link-root Link-isFullCard')[a].text.trim();
        url=todas_las_noticias.getElementsByClassName('Link-root Link-isFullCard')[a].attributes['href']!.trim();
        noticias_principal_portada.add(Noticias('',tittle , 'https://actualidad.rt.com/$url', url_picture,'',-1,1));

      }
    }
    //newsSink(noticias_principal_portada);
    return  noticias_principal_portada;
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
      String url_cubadebate=web_cubadebate.getElementsByClassName('title')[i+1]
                                          .children[0]
                                          .attributes['href']!.trim();
      String tittle_cubadebate=web_cubadebate.getElementsByClassName('title')[i+1]
          .children[0]
          .text.trim();
      String subtittle_cubadebate=web_cubadebate.getElementsByClassName('excerpt')[i+1]
          .children[0]
          .text.trim();
      int l=web_cubadebate.getElementsByClassName('spoiler')[i]
          .children.length;
      String url_picture_cubadebate=web_cubadebate.getElementsByClassName('spoiler')[i]
          .children[l-2]
          .children[0]
          .attributes['src']!
          .trim();
      noticias_destacada.add(Noticias(tittle_cubadebate, subtittle_cubadebate, url_cubadebate, url_picture_cubadebate,'',-1,1));

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
    noticias_destacada.add(Noticias(tittle, subtittle, url, url_image,'',-1,1));
    return noticias_destacada;
  }

}







