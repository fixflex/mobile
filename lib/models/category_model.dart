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
