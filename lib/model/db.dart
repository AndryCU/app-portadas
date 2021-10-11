
import 'dart:io';
import 'package:news_app/model/noticias_model.dart';
export 'package:news_app/model/noticias_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider{
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
    final result=await db!.insert('Noticias', noticia.toJson());

    return result;
  }

  addNoticiaFavoritoActualizandoValor(Noticias noticia) async{
    final db=await database;
    final res=await db!.update('Noticias', noticia.toJson(),where: 'url = ?',whereArgs: [noticia.url]);
  }

  //SELECT FAVORITAS
 Future<List<Noticias>> getNoticiasFavoritas()async{
    final db=await database;
    final res=await db!.query('Noticias',where: 'favorite = 1');
    return res.isNotEmpty?Noticias.fromJson(res):[];
  }

  Future<List<Noticias>> getNoticiasPortada()async{
    final db=await database;
    final res=await db!.query('Noticias',where: 'portada = 1');
    return res.isNotEmpty?Noticias.fromJson(res):[];
  }

  //BORRAR
  borrarTodoFavorito()async{
    final db =await database;
    final res=await db!.delete('Noticias',where: 'favorite = 1');
    return res;
  }

}