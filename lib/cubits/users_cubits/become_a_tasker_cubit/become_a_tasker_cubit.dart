import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'become_a_tasker_state.dart';

class BecomeATaskerCubit extends Cubit<BecomeATaskerState> {
  BecomeATaskerCubit() : super(BecomeATaskerInitial());

  static BecomeATaskerCubit get(context) => BlocProvider.of(context);
  var CategoryController = TextEditingController();



}
