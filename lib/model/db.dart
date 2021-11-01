
import 'dart:io';
import 'package:news_app/model/noticias_model.dart';
import 'package:news_app/model/noticias_provider.dart';
import 'package:news_app/utils/preferences.dart';
export 'package:news_app/model/noticias_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

import 'ConnectionStatus.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db=DBProvider._();

  DBProvider._();

  Future<Database?>get database async{
    if(_database!=null)return _database;
    _database=await initDB();
    return _database;
  }

  initDB() async {
    Directory directory=await getApplicationDocumentsDirectory();
    final path=join(directory.path,'db_news_app.db');
    return await openDatabase(
        path,
        version:1,
        onCreate: (Database db,int version) async{
          await db.execute(
            'CREATE TABLE Noticias('
                'title TEXT,'
                'subtitle TEXT,'
                'url TEXT PRIMARY KEY,'
                'url_image TEXT,'
                'content TEXT,'
                'favorite INTEGER,'
                'portada INTEGER,'
                'destacada INTEGER'
                ')'
          );
    }
    );
  }

  //INSERT
  addNoticiaPortada(Noticias noticia) async{
    final db=await database;
    await db!.insert('Noticias', noticia.toJson());
  }

  addNoticiaFavoritoActualizandoValor(Noticias noticia) async{
    final db=await database;
    await db!.update('Noticias', noticia.toJson(),where: 'id = ?',whereArgs: [noticia.url]);
  }

  borrarPortadaPrincipalesoDestacadas(int valor)async{
    final db=await database;
    //if(preferencias.start){
      await db!.delete('Noticias',where: 'destacada=?',whereArgs: [valor]);
    //}
  }

  //SELECT FAVORITAS
 Future<List<Noticias>> getNoticiasFavoritas()async{
    final db=await database;
    final res=await db!.query('Noticias');
    return res.isNotEmpty?Noticias.fromJson(res):[];
 }

 Future<List<Noticias>> getPrincipalesNews(BuildContext context,bool buscoDB)async{
   
   final db=await database;
    if(Provider.of<StateOfMyApp>(context,listen: false).connected&&buscoDB){
      print('busco en web');
      await NoticiasProvider().principalesNews();
    }
   final res=await db!.query('Noticias',where: 'destacada=0');
   return res.isNotEmpty?Noticias.fromJson(res):[];
  }

  Future<List<Noticias>> getNoticiasDestacadas(BuildContext context,bool busco)async{
    final db=await database;
    if(Provider.of<StateOfMyApp>(context,listen: false).connected &&busco){
         await NoticiasProvider().getDestacadas();
    }
    final res=await db!.query('Noticias',where: 'destacada=1');
    return res.isNotEmpty?Noticias.fromJson(res):[];
  }

  //BORRAR
  borrarTodoFavorito()async{
    final db =await database;
    final res=await db!.delete('Noticias',where: 'favorite = 1');
    return res;
  }

}