part of 'accept_offer_cash_cubit.dart';

@immutable
sealed class AcceptOfferCashState {}

final class AcceptOfferCashInitial extends AcceptOfferCashState {}
final class AcceptOfferCashLoading extends AcceptOfferCashState {}
final class AcceptOfferCashSuccess extends AcceptOfferCashState {}
final class AcceptOfferCashFailure extends AcceptOfferCashState {}