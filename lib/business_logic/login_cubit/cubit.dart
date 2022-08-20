import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/business_logic/login_cubit/states.dart';
import 'package:la_vie/data/models/login_model.dart';
import 'package:la_vie/data/web_services/dio_helper.dart';
import 'package:la_vie/data/web_services/end_points.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  late final LoginModel loginModel;

  void userLogin({
  required String email,
  required String password,
  })
  {
    emit(LoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          "email":email,
          "password":password,
    },).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel.message.toString());
      emit(LoginSuccessState(loginModel));
    }).catchError((error){
      if(error is DioError){
        emit(LoginErrorState(error.response.toString()));
        print(error.response.toString());
      }

    });
  }
}

