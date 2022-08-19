// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/business_logic/registration_cubit/states.dart';
import 'package:la_vie/data/web_services/end_points.dart';

import '../../data/web_services/dio_helper.dart';

class RegistrationCubit extends Cubit<RegistrationStates>{
  RegistrationCubit() : super(RegistrationInitialState());

  static RegistrationCubit get(context) => BlocProvider.of(context);

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
      emit(RegistrationSuccessState());
    }).catchError((error){
      emit(RegistrationErrorState(error.toString()));
      print(error.toString());

    });
  }
}