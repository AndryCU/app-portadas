import 'package:flutter/material.dart';

Widget dilogOffline(BuildContext context){
  return AlertDialog(
                                 title: Text('Alerta'),
                                 content: Text('Sin  conexion a internet'),
                                 actions: [
                                   TextButton(onPressed: (){Navigator.pop(context);}, child: Text('OK'))
                                 ],
                                );
}