part of 'get_address_cubit.dart';

@immutable
sealed class GetAddressState {}

final class GetAddressInitial extends GetAddressState {}
final class GetAddressLoading extends GetAddressState {}
final class GetAddressSuccess extends GetAddressState {}
final class GetAddressFailure extends GetAddressState {}
