// class MyChatsModel {
//   MyChatsModel({
//     required this.results,
//     required this.data,
//   });
//   final int results;
//   final MyChatsDataModel data;
//
//   factory MyChatsModel.fromJson(jsonData) {
//     return MyChatsModel(
//       results: jsonData['results'],
//       data: MyChatsDataModel.fromJson(jsonData['data']),
//     );
//   }
// }
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