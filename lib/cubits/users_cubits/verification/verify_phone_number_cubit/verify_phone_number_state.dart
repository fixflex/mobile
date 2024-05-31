// part of 'verify_phone_number_cubit.dart';
//
// @immutable
// sealed class VerifyPhoneNumberState {}
//
// final class VerifyPhoneNumberInitial extends VerifyPhoneNumberState {}
// final class VerifyPhoneNumberLoading extends VerifyPhoneNumberState {}
// final class VerifyPhoneNumberSuccess extends VerifyPhoneNumberState {}
// final class VerifyPhoneNumberFailure extends VerifyPhoneNumberState {}
// final class VerifyPhoneNumberCodeUpdated extends VerifyPhoneNumberState {}
// final class VerifyPhoneNumberResendCountdown extends VerifyPhoneNumberState {}
// final class VerifyPhoneNumberResendCountdownEnded extends VerifyPhoneNumberState {}


part of 'verify_phone_number_cubit.dart';

abstract class VerifyPhoneNumberState {}

class VerifyPhoneNumberInitial extends VerifyPhoneNumberState {}

class VerifyPhoneNumberCodeUpdated extends VerifyPhoneNumberState {}

class VerifyPhoneNumberLoading extends VerifyPhoneNumberState {}

class VerifyPhoneNumberSuccess extends VerifyPhoneNumberState {}

class VerifyPhoneNumberFailure extends VerifyPhoneNumberState {}

class VerifyPhoneNumberResendCooldown extends VerifyPhoneNumberState {}

class VerifyPhoneNumberResendCountdown extends VerifyPhoneNumberState {
  final int seconds;
  VerifyPhoneNumberResendCountdown(this.seconds);
}

class VerifyPhoneNumberResendCooldownEnded extends VerifyPhoneNumberState {}
