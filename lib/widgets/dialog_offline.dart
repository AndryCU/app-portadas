import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget dilogOffline(BuildContext context){
  return AlertDialog(
    title: Center(child: Icon(Icons.error_outline,color: Colors.red,size: MediaQuery.of(context).size.height*0.05,)),//Center(child: Container(child: Lottie.asset('assets/error.json'),height: MediaQuery.of(context).size.height*0.05,)),
    content: Container(
      child: Column(
        children: [
          Text('Conexión a internet no detectada. Active los datos móviles o conéctese a un red Wi-Fi.',textAlign: TextAlign.left,)
        ],
        mainAxisSize: MainAxisSize.min,
      ),
    ),
  );
}