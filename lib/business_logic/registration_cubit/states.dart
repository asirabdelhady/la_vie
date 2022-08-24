import '../../data/models/login_model.dart';
import '../../data/models/user_model.dart';

abstract class RegistrationStates{}

class RegistrationInitialState extends RegistrationStates{}

class RegistrationLoadingState extends RegistrationStates{}

class RegistrationSuccessState extends RegistrationStates{
  late UserModel registrationModel;

  RegistrationSuccessState(this.registrationModel);
}

class RegistrationErrorState extends   RegistrationStates{
  final String error;
  RegistrationErrorState(this.error);
}



