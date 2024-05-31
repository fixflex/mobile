part of 'update_phone_number_cubit.dart';

@immutable
sealed class UpdatePhoneNumberState {}

final class UpdatePhoneNumberInitial extends UpdatePhoneNumberState {}
final class UpdatePhoneNumberLoading extends UpdatePhoneNumberState {}
final class UpdatePhoneNumberSuccess extends UpdatePhoneNumberState {}
final class UpdatePhoneNumberFailure extends UpdatePhoneNumberState {}
