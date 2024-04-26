part of 'get_categories_cubit.dart';

@immutable
sealed class GetCategoriesState {}

final class LoadingIndicatorInitial extends GetCategoriesState {}

final class NoCategoriesState extends GetCategoriesState {}

final class CategoriesLoadedState extends GetCategoriesState {
  CategoriesLoadedState(this.categories);
  final List<CategoryModel> categories;
}

final class CategoriesErrorState extends GetCategoriesState {}

final class ButtonIsClicked extends GetCategoriesState {
  ButtonIsClicked(
      {required this.categories,
      required this.clickedCategoryId,
      required this.index});
  final List<CategoryModel> categories;
  final String clickedCategoryId;
  final int index;
}

final class ResetButtonStates extends GetCategoriesState {
  ResetButtonStates({required this.categories});
  final List<CategoryModel> categories;
}
