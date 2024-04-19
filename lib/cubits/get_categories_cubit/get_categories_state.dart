part of 'get_categories_cubit.dart';

@immutable
sealed class GetCategoriesState {}

final class LoadingIndicatorInitial extends GetCategoriesState {}

final class NoCategoriesState extends GetCategoriesState {}

final class CategoriesLoadedState extends GetCategoriesState {
  CategoriesLoadedState(this.categories);
  final List<DataModel> categories;
}

final class CategoriesErrorState extends GetCategoriesState {}


