import 'image_model.dart';

class CategoryModel{
  CategoryModel({
    required this.name,
    required this.image,
    required this.id,
  });
  final String name;
  final ImageModel image;
  final String id;

  factory CategoryModel.fromJson(jsonData) {
    return CategoryModel(
      name: jsonData['name'],
      image: ImageModel.fromJson(jsonData['image']),
      id: jsonData['_id'],
    );
  }
}
