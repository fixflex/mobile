part of 'check_personal_information_cubit.dart';

@immutable
sealed class CheckPersonalInformationState {}

final class CheckPersonalInformationInitial extends CheckPersonalInformationState {}
final class MyPersonalInformation extends CheckPersonalInformationState {}
final class OtherUserPersonalInformation extends CheckPersonalInformationState {}
