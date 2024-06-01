abstract class ContactUsState {}

class ContactUsInitial extends ContactUsState {}

final class ContactUsLoadingState extends ContactUsState {}

final class ContactUsSuccessState extends ContactUsState {}

final class ContactUsErrorState extends ContactUsState {
  final String error;
  ContactUsErrorState({required this.error});
}
