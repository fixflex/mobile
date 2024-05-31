part of 'send_verification_code_cubit.dart';

@immutable
sealed class SendVerificationCodeState {}

final class SendVerificationCodeInitial extends SendVerificationCodeState {}
final class SendVerificationCodeLoading extends SendVerificationCodeState {}
final class SendVerificationCodeSuccess extends SendVerificationCodeState {}
final class SendVerificationCodeFailure extends SendVerificationCodeState {}
final class NoPhoneNumber extends SendVerificationCodeState {}
