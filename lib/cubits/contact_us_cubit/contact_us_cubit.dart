import 'package:fix_flex/cubits/contact_us_cubit/contact_us_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(ContactUsInitial());

  static ContactUsCubit get(context) => BlocProvider.of(context);

  var emailController = TextEditingController();
  var MessageController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var isLoading = false;

  String? validateEmail(String? value) {
    if (value?.isEmpty ?? true) {
      return '• This Field can\'t be empty';
    }
    return null;
  }
}
