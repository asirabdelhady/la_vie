import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/business_logic/la_vie_cubit/states.dart';
import 'package:la_vie/business_logic/login_cubit/states.dart';
import 'package:la_vie/data/models/login_model.dart';
import 'package:la_vie/data/web_services/dio_helper.dart';
import 'package:la_vie/data/web_services/end_points.dart';
import 'package:la_vie/presentation/screens/home_screen.dart';
import 'package:la_vie/presentation/screens/leave_screen.dart';
import 'package:la_vie/presentation/screens/notification_screen.dart';
import 'package:la_vie/presentation/screens/profile_screen.dart';
import 'package:la_vie/presentation/screens/qr_code_scanner_screen.dart';
import 'package:la_vie/presentation/widgets/widgets.dart';

class LaVieCubit extends Cubit<LaVieStates>{
  LaVieCubit() : super(LaVieInitialState());

  static LaVieCubit get(context) => BlocProvider.of(context);

  int currentIndex =2;

  int counter =0 ;

  List<Widget> NavBarScreens = [
    LeavesScreen(),
    QrCodeScreen(),
    HomeScreen(),
    NotificationScreen(),
    ProfileScreen()
  ];

  void changeNavBarScreen(context,int index){

    currentIndex = index;
    if(index==1){
      navigateTo(context, QrCodeScreen());
    }
    emit(LaVieChangeNavBarState());
  }

  void increment(){
    counter++;
    emit(LaVieIncrementState());
  }

  void decrement(){
    if(counter>0)
      counter--;
    else
      print('5alas 3rfna enk mesh 3ayez');

  emit(LaVieDecrementState());
  }


}



