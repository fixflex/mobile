part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}
final class RegisterLoadingState extends RegisterState {}
final class RegisterSuccessState extends RegisterState {}
final class PhoneNumberIsAlreadyExist extends RegisterState {}
final class EmailIsAlreadyExist extends RegisterState {}
final class RegisterErrorState extends RegisterState {
  final String error;
  RegisterErrorState({required this.error});
}