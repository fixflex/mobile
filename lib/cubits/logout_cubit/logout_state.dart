class LogoutState {}

final class LogoutInitial extends LogoutState {}

final class LogoutLoadingState extends LogoutState {}

final class LogoutSuccessState extends LogoutState {
  final String message;
  LogoutSuccessState({required this.message});
}

final class LogoutErrorState extends LogoutState {
  final String error;
  LogoutErrorState({required this.error});
}
