
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
                'portada INTEGER'
                ')'
          );
    }
    );
  }

  //INSERT
  addNoticiaPortada(Noticias noticia) async{
    final db=await database;
    await db!.insert('Noticias', noticia.toJson());
    print('annadio ya');
  }

  addNoticiaFavoritoActualizandoValor(Noticias noticia) async{
    final db=await database;
    await db!.update('Noticias', noticia.toJson(),where: 'id = ?',whereArgs: [noticia.url]);
  }

  borrarTodosPortada()async{
    final db=await database;
    final preferencias=PreferenciasUsuario();
    if(preferencias.start){
      await db!.delete('Noticias');
    }


    print('BORRO TODOS');
  }

  //SELECT FAVORITAS
 Future<List<Noticias>> getNoticiasFavoritas()async{
    final db=await database;
    final res=await db!.query('Noticias');
    return res.isNotEmpty?Noticias.fromJson(res):[];
 }

 Future<List<Noticias>> getNoticiasPortada(BuildContext context)async{
   if(Provider.of<ConnectionStatusView>(context).connected){
     print('inicia captura desde internet');
     await NoticiasProvider().principalesNews();
     print('termina captura desde internet');
   }
    final db=await database;
    final res=await db!.query('Noticias');
    print('listo para devolver ${res.length} elementos');
    return res.isNotEmpty?Noticias.fromJson(res):[];
  }

  //BORRAR
  borrarTodoFavorito()async{
    final db =await database;
    final res=await db!.delete('Noticias',where: 'favorite = 1');
    return res;
  }
  borrarParaAnnadir(int pos,Database? dbProvider)async{
    final res=await dbProvider!.query('Noticias');
    if(res.length==5){
      String url=res[pos]['url']as String;
     int r= await dbProvider.delete('Noticias',where: 'url = ?',whereArgs: [url]);
     print(r);
    }
  }

}