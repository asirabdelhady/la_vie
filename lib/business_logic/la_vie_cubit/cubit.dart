import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/business_logic/la_vie_cubit/states.dart';
import 'package:la_vie/business_logic/login_cubit/states.dart';
import 'package:la_vie/data/models/login_model.dart';
import 'package:la_vie/data/models/plants_model.dart';
import 'package:la_vie/data/models/products_model.dart';
import 'package:la_vie/data/models/seeds_model.dart';
import 'package:la_vie/data/models/tools_model.dart';
import 'package:la_vie/data/repository/cache_helper.dart';
import 'package:la_vie/data/web_services/dio_helper.dart';
import 'package:la_vie/data/web_services/end_points.dart';
import 'package:la_vie/presentation/screens/home_screen.dart';
import 'package:la_vie/presentation/screens/leave_screen.dart';
import 'package:la_vie/presentation/screens/notification_screen.dart';
import 'package:la_vie/presentation/screens/profile_screen.dart';
import 'package:la_vie/presentation/screens/qr_code_scanner_screen.dart';
import 'package:la_vie/presentation/widgets/widgets.dart';

import '../../constants/constants.dart';

class LaVieCubit extends Cubit<LaVieStates>{
  LaVieCubit() : super(LaVieInitialState());

  static LaVieCubit get(context) => BlocProvider.of(context);

  var bearerToken= CacheHelper.getData(key: SharedKeys.token);

  int currentIndex =2;

  int counter =0 ;

  PlantsModel? plantsModel;
  SeedsModel? seedsModel;
  ToolsModel? toolsModels;
  ProductsModel? productsModel;


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


  void getPlants(){
    emit(DataLoadingState());

    DioHelper.getData(
        url: PLANTS,
      token: CacheHelper.getData(key: SharedKeys.token)
        ).then((value) {
          print(value.data);
          plantsModel = PlantsModel.fromJson(value.data);
          print(plantsModel!.message.toString());
          emit(DataLoadedState());
        }).catchError((error){
          print(error.toString());
          emit(DataErrorLoadingState());
    });


  }
  void getTools(){
    emit(DataLoadingState());

    DioHelper.getData(
        url: TOOLS,
      token: CacheHelper.getData(key: SharedKeys.token)
        ).then((value) {
          print(value.data);
          toolsModels = ToolsModel.fromJson(value.data);
          print(toolsModels!.message.toString());
          emit(DataLoadedState());
        }).catchError((error){
          print(error.toString());
          emit(DataErrorLoadingState());
    });


  }
  void getProducts(){
    emit(DataLoadingState());
    DioHelper.getData(
        url: PRODUCTS,
      token: CacheHelper.getData(key: SharedKeys.token)
        ).then((value) {
          print(value.data);
          productsModel = ProductsModel.fromJson(value.data);
          print(productsModel!.message.toString());
          emit(DataLoadedState());
        }).catchError((error){
          print(error.toString());
          emit(DataErrorLoadingState());
    });


  }
  void getSeeds(){
    emit(DataLoadingState());

    DioHelper.getData(
        url: SEEDS,
        token: CacheHelper.getData(key: SharedKeys.token)
    ).then((value) {
      print(value.data);
      seedsModel = SeedsModel.fromJson(value.data);
      print(seedsModel!.message.toString());
      emit(DataLoadedState());
    }).catchError((error){
      print(error.toString());
      emit(DataErrorLoadingState());
    });


  }

}



