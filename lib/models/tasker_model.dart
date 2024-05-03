class TaskerModel{
  TaskerModel({
    required this.taskerId,
    required this.userId,
    required this.categories,
    this.ratingAverage,
    this.ratingQuantity,
    this.location,
    this.isActive,
    // this.notPaidTasks,
    this.totalCanceledTasks,
    this.totalEarnings,
    this.netEarnings,
    // this.completedTasks,
    this.commissionRate,
    this.createdAt,
    this.updatedAt,
    // this.reviews,
});

  final String taskerId;
  final String userId;
  final List<String> categories;
  var ratingAverage;
  var ratingQuantity;
  final LocationModel? location;
  final bool? isActive;
  // final List? notPaidTasks;
  final int? totalCanceledTasks;
  var totalEarnings;
  var netEarnings;
  // final List<String>? completedTasks;
  final double? commissionRate;
  final String? createdAt;
  final String? updatedAt;
  // final List<String>? reviews;


  factory TaskerModel.fromJson(jsonData) {
    return TaskerModel(
      taskerId: jsonData['_id'],
      userId: jsonData['userId'],
      categories: List<String>.from(jsonData['categories']),
      ratingAverage: jsonData['ratingAverage'],
      ratingQuantity: jsonData['ratingQuantity'],
      location: LocationModel.fromJson(jsonData['location']),
      isActive: jsonData['isActive'],
      // notPaidTasks: jsonData['notPaidTasks'],
      totalCanceledTasks: jsonData['totalCanceledTasks'],
      totalEarnings: jsonData['totalEarnings'],
      netEarnings: jsonData['netEarnings'],
      // completedTasks: List<String>.from(jsonData['completedTasks']),
      commissionRate: jsonData['commissionRate'],
      createdAt: jsonData['createdAt'],
      updatedAt: jsonData['updatedAt'],
      // reviews: List<String>.from(jsonData['reviews']),
    );
  }
}

class LocationModel{
  LocationModel({
    this.type,
    this.coordinates,
    this.radius,
  });
  final String? type;
  final List<double>? coordinates;
  var radius;

  factory LocationModel.fromJson(jsonData) {
    return LocationModel(
      type: jsonData['type'],
      coordinates: List<double>.from(jsonData['coordinates']),
      radius: jsonData['radius'],
    );
  }
}