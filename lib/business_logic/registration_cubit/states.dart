import '../../data/models/login_model.dart';
import '../../data/models/registration_model.dart';

abstract class RegistrationStates{}

class RegistrationInitialState extends RegistrationStates{}

class RegistrationLoadingState extends RegistrationStates{}

class RegistrationSuccessState extends RegistrationStates{
  late RegistrationModel registrationModel;

  RegistrationSuccessState(this.registrationModel);
}

class RegistrationErrorState extends   RegistrationStates{
  final String error;
  RegistrationErrorState(this.error);
}



