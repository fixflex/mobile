// import 'package:hive/hive.dart';

import 'image_model.dart';
// part 'category_model.g.dart';

// @HiveType(typeId: 0)
class CategoryModel /*extends HiveObject*/ {
  CategoryModel({
    required this.name,
    required this.image,
    required this.id,
  });
  // @HiveField(0)
  final String name;
  // @HiveField(1)
  final ImageModel image;
  // @HiveField(2)
  final String id;

  factory CategoryModel.fromJson(jsonData) {
    return CategoryModel(
      name: jsonData['name'],
      image: ImageModel.fromJson(jsonData['image']),
      id: jsonData['_id'],
    );
  }
}
