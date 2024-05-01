part of 'obscure_password_cubit.dart';

@immutable
sealed class ObscurePasswordState {}

final class ObscurePasswordInitial extends ObscurePasswordState {}
final class LoginObscurePasswordVisibility extends ObscurePasswordState {}
final class LoginObscurePasswordVisibilityOff extends ObscurePasswordState {}
final class RegisterObscurePasswordVisibility extends ObscurePasswordState {}
final class RegisterObscurePasswordVisibilityOff extends ObscurePasswordState {}
final class RegisterObscureConfirmPasswordVisibility extends ObscurePasswordState {}
final class RegisterObscureConfirmPasswordVisibilityOff extends ObscurePasswordState {}
