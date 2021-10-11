import 'package:flutter/material.dart';
import 'package:news_app/bottomNav.dart';
import 'package:news_app/utils/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter News',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BottomNav(),
    );
  }
}
