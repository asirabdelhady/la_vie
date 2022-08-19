abstract class RegistrationStates{}

class RegistrationInitialState extends RegistrationStates{}

class RegistrationLoadingState extends RegistrationStates{}

class RegistrationSuccessState extends RegistrationStates{}

class RegistrationErrorState extends   RegistrationStates{
  final String error;
  RegistrationErrorState(this.error);
}



