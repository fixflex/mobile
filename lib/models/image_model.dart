// import 'package:hive/hive.dart';

// part 'image_model.g.dart';

// @HiveType(typeId: 1)
class ImageModel /*extends HiveObject */{
  ImageModel({
    required this.imageUrl,
  });
  // @HiveField(0)
  final String? imageUrl;

  factory ImageModel.fromJson(jsonData) {
    return ImageModel(
      imageUrl: jsonData['url'],
    );
  }
}
