class TaskerByIdModel{
  TaskerByIdModel({
    required this.taskerId,
    required this.ratingAverage,
    required this.ratingQuantity,
  });
  final String taskerId;
  final double ratingAverage;
  final int ratingQuantity;

  factory TaskerByIdModel.fromJson(jsonData) {
    return TaskerByIdModel(
      taskerId: jsonData['_id'],
      ratingAverage: jsonData['ratingAverage'].toDouble(),
      ratingQuantity: jsonData['ratingQuantity'],
    );
  }
}