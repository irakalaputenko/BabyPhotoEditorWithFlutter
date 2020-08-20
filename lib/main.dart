import 'package:flutter/material.dart';
import 'package:editbaby/Splash/splash_screen.dart';
import 'package:editbaby/Home/home_screen.dart';

// Запуск приложения
void main() => runApp(MyApp());

// Основной виджет приложения
class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    '/Home': (BuildContext context) => HomeScreen(title: 'BABY PHOTO EDITOR')
  };

  @override
  Widget build(BuildContext context) {
    // Это будет приложение с поддержкой Material Design
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BABY PHOTO EDITOR',
      // в котором будет Splash Screen с указанием следующего маршрута
      home: SplashScreen(nextRoute: '/Home'),
      // передаём маршруты в приложение
      routes: routes,
    );
  }
}