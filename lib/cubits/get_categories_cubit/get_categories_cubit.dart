import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../models/category_model.dart';
import '../../services/get_all_categories_service.dart';
part 'get_categories_state.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesState> {
  GetCategoriesCubit(this.getAllCategoriesService) : super(LoadingIndicatorInitial());

  static GetCategoriesCubit get(context) => BlocProvider.of(context);
  GetAllCategoriesService getAllCategoriesService;

Future<void> getCategories() async {
  try {
    emit(LoadingIndicatorInitial());
    final categories = await getAllCategoriesService.GetAllCategories();
    if (categories.isEmpty) {
      emit(NoCategoriesState());
    } else {
      emit(CategoriesLoadedState(categories));
    }
  } catch (e) {
    emit(CategoriesErrorState());
  }
}
}
