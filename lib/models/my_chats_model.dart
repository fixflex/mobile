class MyChatsDataModel {
  MyChatsDataModel({
    required this.id,
    required this.user,
    required this.tasker,
    required this.version,
  });

  final String id;
  final String user;
  final String tasker;
  final int version;

  factory MyChatsDataModel.fromJson(jsonData) {
    return MyChatsDataModel(
      id: jsonData['_id'],
      user: jsonData['user'],
      tasker: jsonData['tasker'],
      version: jsonData['__v'],
    );
  }
}