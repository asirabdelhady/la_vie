import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/business_logic/la_vie_cubit/cubit.dart';
import 'package:la_vie/constants/constants.dart';
import 'package:la_vie/constants/styles.dart';
import 'package:la_vie/business_logic/my_bloc_observer.dart';
import 'package:la_vie/presentation/screens/layout_screen.dart';
import 'package:la_vie/presentation/screens/login_screen.dart';
import 'business_logic/login_cubit/cubit.dart';
import 'business_logic/registration_cubit/cubit.dart';
import 'data/repository/cache_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var myToken = CacheHelper.getData(key: SharedKeys.token);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => LoginCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => RegistrationCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => LaVieCubit()..getSeeds()..getPlants()..getTools()..getProducts()..getForums()..getCurrentUser()..getMyForums(),
        ),
      ],
      child: MaterialApp(
        theme: greenTheme,
        debugShowCheckedModeBanner: false,
        home: myToken != null ?  const LayoutScreen() : const LoginScreen(),
      ),
    );
  }
}
