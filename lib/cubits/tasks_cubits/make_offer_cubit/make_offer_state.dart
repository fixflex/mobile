part of 'make_offer_cubit.dart';

@immutable
sealed class MakeOfferState {}

final class MakeOfferInitial extends MakeOfferState {}
final class MakeOfferLoading extends MakeOfferState {}
final class MakeOfferSuccess extends MakeOfferState {}
final class VerifyPhoneNumber extends MakeOfferState {}
final class MakeOfferFailure extends MakeOfferState {}
