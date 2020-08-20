import 'dart:core';
import 'dart:async';
import 'package:flutter/material.dart';

// Наследуемся от виджета с состоянием,
// то есть виджет для изменения состояния которого не требуется пересоздавать его инстанс
class SplashScreen extends StatefulWidget {
  // переменная для хранения маршрута
  final String nextRoute;

  // конструктор, тело конструктора перенесено в область аргументов,
  // то есть сразу аргументы передаются в тело коструктора и устанавливаются внутренним переменным
  // Dart позволяет такое
  SplashScreen({this.nextRoute});

  // все подобные виджеты должны создавать своё состояние,
  // нужно переопределять данный метод
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

// Создаём состояние виджета
class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  // Инициализация состояния
  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 2),
    );

    animationController.repeat();
    // Создаём таймер, который должен будет переключить SplashScreen на HomeScreen через 3 секунды
    Timer(Duration(seconds: 3),
        // Для этого используется статический метод навигатора
        // Это очень похоже на передачу лямбда функции в качестве аргумента std::function в C++
            () {
          Navigator.of(context).pushReplacementNamed(widget.nextRoute);
        });
  }

  // Формирование виджета
  @override
  Widget build(BuildContext context) {
    // А вот это вёрстка виджета,
    // немного похоже на QML хотя явно не JSON структура
    return new Scaffold(
        body: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/background.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            new Center(
                child: new AnimatedBuilder(
                  animation: animationController,
                  child: new Container(
                    child: Image.asset('assets/logo.png'),
                  ),
                  builder: (BuildContext context, Widget _widget){
                    return new Transform.rotate(
                      angle: animationController.value * 6.3,
                      child: _widget,
                    );
                  },
                ))
          ],
        ));
  }
}
