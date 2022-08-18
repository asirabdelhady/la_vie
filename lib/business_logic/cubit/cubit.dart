import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/business_logic/cubit/states.dart';
import 'package:la_vie/data/web_services/dio_helper.dart';
import 'package:la_vie/data/web_services/end_points.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

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
      emit(LoginSuccessState());
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
      print(error.toString());

    });
  }
}

