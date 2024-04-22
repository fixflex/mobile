part of 'obscure_password_cubit.dart';

@immutable
sealed class ObscurePasswordState {}

final class ObscurePasswordInitial extends ObscurePasswordState {}
final class ObscurePasswordVisibility extends ObscurePasswordState {}
final class ObscurePasswordVisibilityOff extends ObscurePasswordState {}
