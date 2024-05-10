import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'budget_state.dart';

class BudgetCubit extends Cubit<BudgetState> {
  BudgetCubit() : super(BudgetInitial());

  static BudgetCubit get(context) => BlocProvider.of(context);
  TextEditingController budgetController = TextEditingController();
  late int newBudget;

  void addToBudget(String value) {
    if (budgetController.text.length < 5) {
      if(budgetController.text.isEmpty && value == '0'){
        return;
      }else{
         newBudget = int.tryParse(budgetController.text + value) ?? 0;

        if(newBudget >=10){
          budgetController.text += value;
          emit(BudgetAdded());
          emit(LastBudget());
        }else{
          budgetController.text += value;
          emit(BudgetAdded());
          emit(LessThenMinimumBudget());
        }
         }
    }
  }

  void removeFromBudget() {
    if (budgetController.text.isNotEmpty) {
      budgetController.text = budgetController.text.substring(0, budgetController.text.length - 1);
      emit(BudgetRemoved());
      newBudget = int.tryParse(budgetController.text) ?? 0;
      if(newBudget < 10){
        emit(LessThenMinimumBudget());
      }else{
        emit(LastBudget());
      }
    }
  }

  void resetBudgetCubit(){
    budgetController.clear();
    newBudget = 0;
    emit(BudgetInitial());
  }
}
