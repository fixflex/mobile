abstract class LoginState {}

class LoginInitial extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginSuccessState extends LoginState {}

final class LoginErrorState extends LoginState {
  final String error;
  LoginErrorState({required this.error});
}
