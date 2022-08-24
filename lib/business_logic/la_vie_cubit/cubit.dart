import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/business_logic/la_vie_cubit/states.dart';
import 'package:la_vie/business_logic/login_cubit/states.dart';
import 'package:la_vie/data/models/forums_model.dart';
import 'package:la_vie/data/models/login_model.dart';
import 'package:la_vie/data/models/plants_model.dart';
import 'package:la_vie/data/models/products_model.dart';
import 'package:la_vie/data/models/seeds_model.dart';
import 'package:la_vie/data/models/tools_model.dart';
import 'package:la_vie/data/repository/cache_helper.dart';
import 'package:la_vie/data/web_services/dio_helper.dart';
import 'package:la_vie/data/web_services/end_points.dart';
import 'package:la_vie/presentation/screens/home_screen.dart';
import 'package:la_vie/presentation/screens/forums_screen.dart';
import 'package:la_vie/presentation/screens/notification_screen.dart';
import 'package:la_vie/presentation/screens/profile_screen.dart';
import 'package:la_vie/presentation/screens/qr_code_scanner_screen.dart';
import 'package:la_vie/presentation/widgets/widgets.dart';

import '../../constants/constants.dart';
import '../../data/models/user_model.dart';

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
  ForumsModel? forumsModel;
  ForumsModel? myForumModel;
  UserModel? userModel;


  List<Widget> NavBarScreens = [
    ForumsScreen(),
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
  void getForums(){
    emit(DataLoadingState());
    DioHelper.getData(
        url: FORUMS,
        token: CacheHelper.getData(key: SharedKeys.token)
    ).then((value) {
      print(value.data);
      forumsModel = ForumsModel.fromJson(value.data);
      print(forumsModel!.message.toString());
      emit(DataLoadedState());
    }).catchError((error){
      print(error.toString());
      emit(DataErrorLoadingState());
    });


  }
  void getMyForums(){
    emit(DataLoadingState());
    DioHelper.getData(
        url: FORUMS,
        token: CacheHelper.getData(key: SharedKeys.token)
    ).then((value) {
      print(value.data);
      myForumModel = ForumsModel.fromJson(value.data);
      print(myForumModel!.message.toString());
      emit(DataLoadedState());
    }).catchError((error){
      print(error.toString());
      emit(DataErrorLoadingState());
    });


  }
  void getCurrentUser(){
    emit(DataLoadingState());
    DioHelper.getData(
        url: CURRENT_USER,
        token: CacheHelper.getData(key: SharedKeys.token)
    ).then((value) {
      print(value.data);
      userModel = UserModel.fromJson(value.data);
      print(userModel!.message.toString());
      emit(DataLoadedState());
    }).catchError((error){
      print(error.toString());
      emit(DataErrorLoadingState());
    });


  }


  submitPost({
    required String title,
    required String description,
    required String imageBase64,
}){
    emit(DataLoadingState());
    DioHelper.postData(
      token: CacheHelper.getData(key: SharedKeys.token),
        url: '/api/v1/forums',
        data: {
          'title': title,
          'description': description,
          'imageBase64': imageBase64
        }).then((value) {
          emit(DataLoadedState());
          print(value.data);

          return ;
        });
  }
}



