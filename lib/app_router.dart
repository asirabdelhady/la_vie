import 'package:flutter/material.dart';
import 'package:la_vie/constants/strings.dart';
import 'package:la_vie/presentation/screens/login_screen.dart';
import 'package:la_vie/presentation/screens/splash_screen.dart';

class AppRouter{
  Route? generateRouter(RouteSettings settings){
    switch (settings.name){
      case homePageRoute:
        return MaterialPageRoute(builder: (_)=> LoginScreen());

    }
  }

}