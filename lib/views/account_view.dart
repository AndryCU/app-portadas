import 'package:flutter/material.dart';
import 'package:news_app/utils/preferences.dart';

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final  prefs=PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Text('Configuracion',style: TextStyle(color: Colors.teal,fontSize: 20),),
            margin: EdgeInsets.symmetric(vertical: 10),
          ),
          SwitchListTile(
            title: Text('Cargar imágenes'),
            value: prefs.loadImage,
            onChanged: (bool value){
              setState(()=>prefs.loadImage=value);
            },
            secondary: Icon(Icons.hide_image),
            subtitle: Text('Activa o desactiva la carga de imagenes desde la web.'),
            
          )
        ],
      )
    );
  }
}
