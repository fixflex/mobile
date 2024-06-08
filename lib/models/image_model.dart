class ImageModel{
  ImageModel({
    this.imageUrl,
  });
  final String? imageUrl;

  factory ImageModel.fromJson(jsonData) {
    return ImageModel(
      imageUrl: jsonData['url'],
    );
  }
}
