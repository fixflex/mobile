part of 'budget_cubit.dart';

@immutable
sealed class BudgetState {}

final class BudgetInitial extends BudgetState {}
final class BudgetAdded extends BudgetState {}
final class LessThenMinimumBudget extends BudgetState {}
final class BudgetRemoved extends BudgetState {}
final class LastBudget extends BudgetState {}
