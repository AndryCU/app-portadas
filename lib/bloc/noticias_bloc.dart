
import 'dart:async';

import 'package:news_app/model/db.dart';
import 'package:news_app/model/noticias_provider.dart';

class NoticiasBloc{
  static final NoticiasBloc _singlenton=NoticiasBloc._internal();
  //final _noticiasController=StreamController<List<Noticias>>.broadcast();
  //Stream<List<Noticias>> get noticiasStream =>_noticiasController.stream;

  NoticiasBloc._internal(){  //obtenerNoticias();

 }

  factory NoticiasBloc (){
    return _singlenton;
  }


  //agregarNoticiasPortadaPrincipalessssssss() async {
  //  List<Noticias> principales=await NoticiasProvider().principalesNews();
  //  print('agregarNoticiasPortadaPrincipales: ${principales.length}');
  //  for (var n in principales){
  //    await DBProvider.db.addNoticiaPortada(n);
  //  }
  //}

  Future<List<Noticias>>obtenerNoticias()async{
    return DBProvider.db.getNoticiasPortada();
  }

  borrarFavoritas() async{
    await DBProvider.db.borrarTodoFavorito();
  }

}