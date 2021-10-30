import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'db.dart';
import 'noticias_model.dart';

class NoticiasProvider{
  //OBTENGO LAS NOTICIAS QUE VAN EN LA LISTA HORIZONTAL
   principalesNews()async{
    await DBProvider.db.borrarPortadaPrincipales();
    String url_picture='';
    String tittle='';
    String url='';
    bool flag=false;
    final response_viral =await http.Client().get(Uri.parse("https://actualidad.rt.com/viral"));
    var viral=parser.parse(response_viral.body);
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
      await DBProvider.db.addNoticiaPortada(Noticias('VIRAL', subtittle, 'https://actualidad.rt.com$url2', url_image, '', -1, 1,0));
      //noticias_principal_portada.add(Noticias('VIRAL', subtittle, 'https://actualidad.rt.com$url2', url_image.toString(),'',-1,-1,0));
      final lista= await getNewsRT(4);
      for (var noticia in  lista) {
        await DBProvider.db.addNoticiaPortada(noticia);
      }
     
    }
  }

 Future<List<Noticias>> getNewsRT(int cant_noticias)async{
     final response_todas_las_noticias =await http.Client().get(Uri.parse("https://actualidad.rt.com/todas_las_noticias"));
     var todas_las_noticias=parser.parse(response_todas_las_noticias.body);
     String url_picture='';
     String tittle='';
     String url='';
     bool flag=false;
     List<Noticias> noticias_principal_portada=[];     

      for (int a=0;a<cant_noticias;a++){
        //NOTICIAS
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
        //await DBProvider.db.addNoticiaPortada(Noticias('',tittle , 'https://actualidad.rt.com/$url', url_picture.toString(),'',-1,1,0));
        noticias_principal_portada.add(Noticias('',tittle , 'https://actualidad.rt.com/$url', url_picture.toString(),'',-1,1,0));
      }
      return noticias_principal_portada;
  }

  //OBTENGO LAS NOTICIAS QUE VAN EN LA LISTA VERTICAL
   getDestacadas()async{
    await DBProvider.db.borrarPortadaDestacadas();
    //CUBADEBATE//
    final response_cubadebate =await http.Client().get(Uri.parse("http://www.cubadebate.cu/"));
    var web_cubadebate=parser.parse(response_cubadebate.body);
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
      String url_picture_cubadebate='';
      try{
        url_picture_cubadebate=noticia.getElementsByClassName('spoiler')[0].children[0].children[0].attributes['src']!.trim();
        url_picture_cubadebate=await downloadAndPath(url_picture_cubadebate);
      }catch(e){
        url_picture_cubadebate='assets/foto-no-disponible.jpg';
      }
      //noticias_destacada.add(Noticias(tittle_cubadebate, subtittle_cubadebate, url_cubadebate, url_picture_cubadebate, '', 0, 1, 1));

        await DBProvider.db.addNoticiaPortada(Noticias(tittle_cubadebate, subtittle_cubadebate, url_cubadebate, url_picture_cubadebate, '', -1, 1, 1)) ;
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
    String url_image='';
    try{
       url_image=web2.getElementsByClassName('Cover-image')[0]
          .children[0]
          .children[2]
          .attributes['data-src']
          .toString();
       url_image=await downloadAndPath(url_image);
    }catch(e){
          url_image='assets/foto-no-disponible.jpg';
    }
    String subtittle=web2.getElementsByClassName('ArticleView-summary')[0]
        .children[0]
        .text
        .trim();
    //noticias_destacada.add(Noticias(tittle, subtittle, url.toString(), url_image.toString(),'',-1,1,1));
    await DBProvider.db.addNoticiaPortada(Noticias(tittle, subtittle, url, url_image, '', -1, 1, 1));
    //return noticias_destacada;
  }

  //DESCARGO LAS IMAGENES
  Future<String> downloadAndPath(String url) async{
    final directory=await getApplicationDocumentsDirectory();
    String ext='';
    if(url.contains('.jpeg')){
      ext='.jpeg';
    }
    if(url.contains('.jpg')){
      ext='.jpg';
    }
    if(url.contains('.png')){
      ext='.png';
    }
    try{
      final path='${directory.path}/imagenes_descargadas/${url.substring(url.length-14,url.length-4).toString()}$ext';
      final foto=File(path);
      final response=await Dio().get(url,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 0
          ));
      final raf=foto.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return foto.path;
    }catch (e){
      print(e.toString());
      return '';
    }
 }

   writteText(String url,String file_name)async{
     final Directory directory = await getApplicationDocumentsDirectory();
     final File file = File('${directory.path}/$file_name.json');
     final response_cubadebate =await http.Client().get(Uri.parse(url));
     var web_cubadebate=parser.parse(response_cubadebate.body);
     final cuerpo= web_cubadebate.getElementsByClassName('note_content')[0];
     final ini_json='{"fuente":"cubadebate",\n"parrafos":[\n';
     file.writeAsStringSync(ini_json,mode: FileMode.append);
     List<String> temp=[];
     for(var i=0;i<cuerpo.children.length;i++){
       String t='';
       if(cuerpo.children[i].toString()=='<html ul>'){
         t=forULElements(cuerpo.children[i].children); //abrirycerrarEtiquetas(cuerpo.children[i].toString(),cuerpo.children[i].text.trim());
       }else{
         t=abrirycerrarEtiquetas(cuerpo.children[i].toString(),cuerpo.children[i].text.trim());
       }

       if(cuerpo.children.length==i+1 && t.isNotEmpty){
         t=t.substring(0,t.length-2);
       }
       if(cuerpo.children.length==i+1 && t.isEmpty){
         temp[i-1]=temp[i-1].substring(0,temp[i-1].length-2);
       }
       if(t.isNotEmpty){
         temp.add(t);
       }
     }

     for (var texto in temp){
       file.writeAsStringSync(texto,mode: FileMode.append);
     }
     final end_json=']\n}';
     file.writeAsStringSync(end_json,mode: FileMode.append);
   }

   Future<String> read(String file_name) async {
     late Future<String> text;
     try {
       final Directory directory = await getApplicationDocumentsDirectory();
       final File file = File('${directory.path}/$file_name.json');
       text = file.readAsString();
       log(await text);
     } catch (e) {
       print(e.toString());
     }
     return text;
   }

   String abrirycerrarEtiquetas(String e,String texto) {
     print(e);
     switch (e){
       case '<html p>':{
         return texto.isEmpty?'':'{'
             '"etiqueta":"p",'
             '"texto":"$texto"'
             '},\n';
       }
       case '<html blockquote>':{
         return texto.isEmpty?'': '{'
             '"etiqueta":"blockquote",'
             '"texto":"$texto"'
             '},\n';
       }
       case '<html h3>':{
         return texto.isEmpty?'': '{'
             '"etiqueta":"h3",'
             '"texto":"$texto"'
             '},\n';
       }
     }
     return '';
   }

   String forULElements(List<Element> e){
     String init_ul='"{etiqueta": "ul","texto":[';
     for(int i=0;i<e.length;i++){
       if(i+1==e.length){
         init_ul+='{"etiqueta":"li","texto":"${e[i].text}"}';
       }else{
         init_ul+='{"etiqueta":"li","texto":"${e[i].text}"},';
       }
     }
     init_ul+=']},\n';


     return init_ul;
   }

}










