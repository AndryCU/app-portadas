import 'package:flutter/material.dart';
import 'package:news_app/model/db.dart';

class StateOfMyApp with ChangeNotifier{
  static StateOfMyApp? _instancia;  
  bool _connected=false;
  int _initCargo=-1;
  StateOfMyApp._internal();
  bool get connected => _connected;

  Future<List<Noticias>> getNoticias(BuildContext context)async{
   if(_initCargo==0){
     return DBProvider.db.getPrincipalesNews(context,true);
   }else{
     return DBProvider.db.getPrincipalesNews(context,false);
   }
  }

   Future<List<Noticias>> getDestacadas(BuildContext context)async{
   if(_initCargo==0){
     return DBProvider.db.getNoticiasDestacadas(context,true);
   }else{
     return DBProvider.db.getNoticiasDestacadas(context,false);
   }
  }
  
factory StateOfMyApp(){
  if (_instancia==null){
    _instancia=new StateOfMyApp._internal();
  }
  return _instancia!;
}

  set connected(bool value) {
    _connected = value;
    notifyListeners();
  }

  int get getinitCargo=>_initCargo;

  set setinitCargo(int v){
    _initCargo+=v;
  }

}