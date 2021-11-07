import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news_app/bottomNav.dart';
import 'package:news_app/model/StateOfMyApp.dart';
import 'package:news_app/utils/preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    crearDirectorio();
    return ChangeNotifierProvider(
      create: (context)=>StateOfMyApp(),
      child: MaterialApp(
        title: 'Flutter News',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BottomNav()
      ),
    );
  }

  crearDirectorio()async {
    final directory = await getApplicationDocumentsDirectory();
    final dirPath = '${directory.path}/imagenes_descargadas';
    if (!await Directory(dirPath).exists()) {
      await new Directory(dirPath).create();
    }
  }
}

