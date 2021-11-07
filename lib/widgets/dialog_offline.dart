import 'package:flutter/material.dart';

Widget dilogOffline(BuildContext context){
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Stack(children: [
      Container(
        height: 170,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 48, 10, 10),
          child: Column(
            children: [
              Text('Error al cargar noticia',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              Text('Active los datos móviles o conéctese a una red Wi-Fi.',style: TextStyle(fontSize: 15),),
              TextButton(onPressed: ()=>Navigator.of(context).pop(), child: Text('OK'))
            ],
          ),
        ),
      ),
      Positioned(child: CircleAvatar(
        child: Icon(Icons.error,color: Colors.white,size: 60,),
        backgroundColor: Colors.red,
        radius: 30,
        ),
        top: -30,
        )

    ],
    alignment: Alignment.topCenter,
    clipBehavior: Clip.none,
    ),
  );
}