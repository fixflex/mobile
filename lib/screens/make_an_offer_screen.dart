import 'package:fix_flex/components/select_a_budget.dart';
import 'package:fix_flex/cubits/users_cubits/update_phone_number_cubit/update_phone_number_cubit.dart';
import 'package:fix_flex/cubits/users_cubits/verification/verify_phone_number_cubit/verify_phone_number_cubit.dart';
import 'package:fix_flex/screens/post_a_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/offer_message.dart';
import '../constants/constants.dart';
import '../cubits/tasks_cubits/budget_cubit/budget_cubit.dart';
import '../cubits/tasks_cubits/details_cubit/details_cubit.dart';
class MakeAnOfferScreen extends StatelessWidget {
  const MakeAnOfferScreen({super.key});

  static const String id = 'MakeAnOfferScreen';

  @override
  Widget build(BuildContext context) {
    Future<bool> _popScope() async {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Discard Offer?'),
          content: Text('Are you sure you want to discard this Offer?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                BudgetCubit.get(context).resetBudgetCubit();
                DetailsCubit.get(context).resetDetailsCubit();
                VerifyPhoneNumberCubit.get(context).resetVerifyPhoneNumberCubit();
                UpdatePhoneNumberCubit.get(context).resetUpdatePhoneNumberCubit();
                Navigator.pop(context, true);
              },
              child: Text('Yes'),
            ),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: _popScope,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Make An Offer'),
        ),
        body: NumKeyWidget(
          title:'Enter Your Offer',
          description: 'Enter your offer amount',

        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
        BlocBuilder<BudgetCubit, BudgetState>(builder: (context, state) {
            return FloatingActionButtonInPostATask(
              backgroundColor: state is LastBudget ? kPrimaryColor : Colors.grey,
              text: 'Continue',
              onPressed: () {
                state is LastBudget ? Navigator.pushNamed(context, OfferMessage.id): null;
              },
            );
          },
        ),
      ),
    );
  }
}
