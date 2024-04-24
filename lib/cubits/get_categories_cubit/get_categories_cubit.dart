import 'package:fix_flex/helper/network/dio_api_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../constants/end_points/end_points.dart';
import '../../models/category_model.dart';
part 'get_categories_state.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesState> {
  GetCategoriesCubit() : super(LoadingIndicatorInitial());

  static GetCategoriesCubit get(context) => BlocProvider.of(context);
  List<DataModel> dataList = [];
  List<bool> buttonClickedStates = [false, false, false, false, false, false];


  Future<void> getCategories() async {
    try {
      emit(LoadingIndicatorInitial());
      var jsonData = (await DioApiHelper.getData(
          url:EndPoints.categories));
      List<dynamic> categories = jsonData.data['data'];
      if (categories.isEmpty) {
        emit(NoCategoriesState());
      } else {
        for (var category in categories) {
          DataModel dataModel = DataModel.fromJson(category);
          dataList.add(dataModel);
        }
        emit(CategoriesLoadedState(dataList));
      }
    } catch (e) {
      emit(CategoriesErrorState());
    }
  }

  void handleButtonTap(int index) {
    for (int i = 0; i < buttonClickedStates.length; i++) {
      if (i == index) {
        buttonClickedStates[i] = !buttonClickedStates[i]; // Toggle the state of the clicked button
      } else {
        buttonClickedStates[i] = false; // Reset the state of other buttons
      }
    }
    emit(ButtonIsClicked(dataList));
  }
}
