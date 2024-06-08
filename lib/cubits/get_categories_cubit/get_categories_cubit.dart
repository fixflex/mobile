import 'package:fix_flex/helper/network/dio_api_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../constants/end_points/end_points.dart';
import '../../models/category_model.dart';
part 'get_categories_state.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesState> {
  GetCategoriesCubit() : super(LoadingIndicatorInitial());

  static GetCategoriesCubit get(context) => BlocProvider.of(context);
  List<CategoryModel> categoriesDataList = [];
  List<CategoryModel> categoriesDataListWithoutMore = [];
  List<bool> buttonClickedStates = [];
  String clickedCategoryId = '';
  int clickedCategoryIndex = 0;

  Future<void> getCategories() async {
    try {
      emit(LoadingIndicatorInitial());
      var response = (await DioApiHelper.getData(url: EndPoints.categories));
      if(response.statusCode == 200){
        List<dynamic> categories = response.data['data'];
        if (categories.isEmpty) {
          emit(NoCategoriesState());
        } else {
          for (var category in categories) {
            buttonClickedStates.add(false);
            CategoryModel categoryModel = CategoryModel.fromJson(category);
            categoriesDataList.add(categoryModel);
            if (categoryModel.name != 'More') {
              categoriesDataListWithoutMore.add(categoryModel);
            }
          }
          emit(CategoriesLoadedState(categoriesDataList));
        }
      }else{
        emit(CategoriesErrorState());
      }
    } catch (e) {
      emit(CategoriesErrorState());
    }
  }

  void handleButtonTap(int index) {
    for (int i = 0; i < buttonClickedStates.length; i++) {
      if (i == index) {
        buttonClickedStates[i] = !buttonClickedStates[i];
        clickedCategoryId = categoriesDataList[i].id;
        clickedCategoryIndex = index;
      } else {
        buttonClickedStates[i] = false;
      }
    }
    emit(ButtonIsClicked(
        categories: categoriesDataList, clickedCategoryId: clickedCategoryId, index: index ,));
  }
  void resetButtonStates() {
    for (int i = 0; i < buttonClickedStates.length; i++) {
      buttonClickedStates[i] = false;
    }
    emit(ResetButtonStates(categories: categoriesDataList));
  }
  void resetGetCategoriesCubit() {
    categoriesDataList = [];
    categoriesDataListWithoutMore = [];
    buttonClickedStates = [];
    clickedCategoryId = '';
    clickedCategoryIndex = 0;
    emit(LoadingIndicatorInitial());
  }
}
