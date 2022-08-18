import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:la_vie/app_router.dart';
import 'package:la_vie/constants/styles.dart';
import 'package:la_vie/business_logic/my_bloc_observer.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    Bloc.observer = MyBlocObserver();
    return MaterialApp(
      theme: greenTheme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRouter,
    );
  }
}
