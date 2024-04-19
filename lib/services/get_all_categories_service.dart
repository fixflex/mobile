import 'package:fix_flex/helper/api.dart';
import 'package:fix_flex/models/category_model.dart';

class GetAllCategoriesService {
  Future<List<DataModel>> GetAllCategories() async {
    Map<String, dynamic> jsonData =
        await Api().get(url: 'https://fixflex.onrender.com/api/v1/categories');
    List<dynamic> categories = jsonData['data'];
    List<DataModel> dataList = [];

    for (var category in categories) {
      DataModel dataModel = DataModel.fromJson(category);
      dataList.add(dataModel);
    }
    return dataList;
  }
}

// for(int i = 0 ;i<categories.length;i++){
//   dataList.add(DataModel.fromJson(categories[i]));
//   print(dataList);
// }


// for(var category in categories){
//   DataModel dataModel = DataModel.fromJson(category);
//   dataList.add(dataModel);
// }
