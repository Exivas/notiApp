import 'package:flutter/material.dart';
import 'vistas/GeneroEdad.dart';
import 'vistas/Universidad.dart';
import 'vistas/tiempo.dart';
import 'vistas/Noticias.dart';
import 'vistas/about_Me.dart';
import 'vistas/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noti App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
      routes: {
        '/gender_age': (context) => GenderAgeView(),
        '/universities': (context) => UniversitiesView(),
        '/weather': (context) => WeatherView(),
        '/news': (context) => NewsView(),
        '/about': (context) => AboutView(),
      },
    );
  }
}
