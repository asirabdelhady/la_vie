// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/business_logic/registration_cubit/states.dart';
import 'package:la_vie/data/models/registration_model.dart';
import 'package:la_vie/data/web_services/end_points.dart';
import '../../data/web_services/dio_helper.dart';

class RegistrationCubit extends Cubit<RegistrationStates>{
  RegistrationCubit() : super(RegistrationInitialState());


  static RegistrationCubit get(context) => BlocProvider.of(context);

  late final RegistrationModel registrationModel;
  void userRegistration({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
  })
  {
    emit(RegistrationLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        "firstName":firstName,
        "lastName":lastName,
        "email":email,
        "password":password,
        "confirmPassword":confirmPassword,
      },).then((value) {
      print(value.data);
      registrationModel=RegistrationModel.fromJson(value.data);
      print(registrationModel.type);
      emit(RegistrationSuccessState(registrationModel));
    }).catchError((error){
      if(error is DioError){
        emit(RegistrationErrorState(error.response.toString()));
        print(error.response.toString());
      }

    });
  }
}