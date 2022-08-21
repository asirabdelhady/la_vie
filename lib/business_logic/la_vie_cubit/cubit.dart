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

class LaVieCubit extends Cubit<LaVieStates>{
  LaVieCubit() : super(LaVieInitialState());

  static LaVieCubit get(context) => BlocProvider.of(context);

  late bool isSelected;
  int currentIndex =2;

  List<Widget> NavBarScreens = [
    LeavesScreen(),
    QrCodeScreen(),
    HomeScreen(),
    NotificationScreen(),
    ProfileScreen()
  ];

  void changeNavBarScreen(int index){
    currentIndex = index;
    emit(LaVieChangeNavBarState());
  }
  void changeCategoryTitle(int index, textColor, backGroundColor, borderColor){
    List selectedIndexs=[];

    bool isSelected= selectedIndexs.contains(index,);

    if(isSelected != null){
      selectedIndexs.add(index);
      isSelected = true;
      if(isSelected){
        textColor= Colors.green;
        backGroundColor= Colors.white;
        borderColor=Colors.green;
      }
    }else if(isSelected == null) {
      selectedIndexs.add(index);
    }
    emit(LaVieChangeCategoryTitleState());
    print(selectedIndexs);
    print(isSelected);
  }
  void changeColor(color){
    final color= Colors.green;
    emit(LaVieChangeCategoryTitleState());
  }

}



