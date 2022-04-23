
import 'package:bloc_example/logic/cubit/counter_cubit.dart';
import 'package:bloc_example/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/second_screen.dart';
import '../screens/third_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
          return MaterialPageRoute(builder: (_) => HomeScreen(title: "HomeScreen", color: Colors.blueAccent));
      case "/second":
          return MaterialPageRoute(builder: (_) => SecondScreen(title: "SecondScreen", color: Colors.redAccent));
      case "/third":
          return MaterialPageRoute(builder: (_) => ThirdScreen(title: "ThirdScreen", color: Colors.greenAccent));
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen(title: "title", color: Colors.yellowAccent));
    }
  }
}