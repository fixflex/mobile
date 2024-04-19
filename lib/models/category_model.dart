// class CategoryModel {
//   CategoryModel({
//     // required this.onTap,
//     required this.data,
//   });
//
//   // final Function onTap;
//   final DataModel data;
//
//   factory CategoryModel.fromJson(jsonData) {
//     return CategoryModel(
//       // onTap: jsonData['onTap'],
//       data: DataModel.fromJson(jsonData['data']),
//     );
//   }
// }

class DataModel {
  DataModel({
    required this.name,
    required this.image,
    required this.id,
  });
  final String name;
  final ImageModel image;
  final String id;

  factory DataModel.fromJson(jsonData) {
    return DataModel(
      name: jsonData['name'],
      image: ImageModel.fromJson(jsonData['image']),
      id: jsonData['_id'],
    );
  }
}

class ImageModel {
  ImageModel({
    required this.imageUrl,
  });
  final String? imageUrl;

  factory ImageModel.fromJson(jsonData) {
    return ImageModel(
      imageUrl: jsonData['url'],
    );
  }
}
