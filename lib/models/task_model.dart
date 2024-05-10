import 'dart:convert';

class TaskModel {
  TaskModel({
    this.dueDate,
    this.location,
    this.id,
    this.userId,
    this.taskerId,
    this.time,
    required this.title,
    this.details,
    this.categoryId,
    this.status,
    this.city,
    required this.budget,
    this.offersId,
    this.offerDetails,
    this.paymentMethod,
    this.paid,
    this.images,
    this.createdAt,
    this.updatedAt,
  });

  final DueDate? dueDate;
  final Location? location;
  final String? id;
  final UserId? userId;
  final String? taskerId;
  final String? time;
  final String title;
  final String? details;
  final String? categoryId;
  final String? status;
  final String? city;
  final int budget;
  final List<dynamic>? offersId;
  final List<OfferDetails>? offerDetails;
  final String? paymentMethod;
  final bool? paid;
  final List<TaskImages>? images;
  final String? createdAt;
  final String? updatedAt;

  factory TaskModel.fromJson(jsonData) {
    return TaskModel(
      dueDate: DueDate.fromJson(jsonData['dueDate']),
      location: Location.fromJson(jsonData['location']),
      id: jsonData['_id'],
      userId: UserId.fromJson(jsonData['userId']),
      taskerId: jsonData['taskerId'],
      time: jsonData[0],
      title: jsonData['title'],
      details: jsonData['details'],
      categoryId: jsonData['categoryId'],
      status: jsonData['status'],
      city: jsonData['city'],
      budget: jsonData['budget'],
      offersId: (jsonData['offers'] != null)
          ? List<dynamic>.from(jsonData['offers'])
          : null,
      offerDetails: (jsonData['offersDetails'] != null)
          ? List<OfferDetails>.from(jsonData['offersDetails'].map((x) => OfferDetails.fromJson(x)))
          : null,
      paymentMethod: jsonData['paymentMethod'],
      paid: jsonData['paid'],
      images: (jsonData['images'] != null)
          ? List<TaskImages>.from(jsonData['images'].map((x) => TaskImages.fromJson(x)))
          : null,
      createdAt: jsonData['createdAt'],
      updatedAt: jsonData['updatedAt'],
    );
  }
}

class DueDate {
  DueDate({
    this.on,
    this.before,
    this.flexible,
  });

  final String? on;
  final String? before;
  final bool? flexible;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (on != null) data['on'] = on;
    if (before != null) data['before'] = before;
    if (flexible != false) data['flexible'] = flexible;
    return data;
  }

  factory DueDate.fromJson(Map<String, dynamic> jsonData) {
    return DueDate(
      on: jsonData['on'],
      before: jsonData['before'],
      flexible: jsonData['flexible'],
    );
  }
}

class Location {
  Location({
     this.coordinates,
     this.online,
  });

  final List<dynamic>? coordinates;
  final bool? online;


  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = {};
    if (coordinates != null) data['coordinates'] = coordinates;
    if (online != false) data['online'] = online;
    return data;
  }

  factory Location.fromJson(Map<String, dynamic> jsonData) {
    return Location(
      coordinates: List<dynamic>.from(jsonData['coordinates']),
      online: jsonData['online'],
    );
  }
}

class UserId {
  UserId({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.emailVerified,
    this.profilePicture,
    this.phoneVerified,
    this.createdAt,
    this.updatedAt,
    this.phoneNumber,
    this.phoneNumVerificationCode,
    this.phoneNumVerificationCodeExpiration,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final bool? emailVerified;
  final ProfilePicture? profilePicture;
  final bool? phoneVerified;
  final String? createdAt;
  final String? updatedAt;
  final String? phoneNumber;
  final String? phoneNumVerificationCode;
  final String? phoneNumVerificationCodeExpiration;

  factory UserId.fromJson(jsonData) {
    if (jsonData is String) {
      return UserId(id: jsonData,);
    }else if(jsonData is Map<String, dynamic>){
    return UserId(
      id: jsonData['_id'],
      firstName: jsonData['firstName'],
      lastName: jsonData['lastName'],
      email: jsonData['email'],
      emailVerified: jsonData['emailVerified'],
      profilePicture: ProfilePicture.fromJson(jsonData['profilePicture']),
      phoneVerified: jsonData['phoneVerified'],
      createdAt: jsonData['createdAt'],
      updatedAt: jsonData['updatedAt'],
      phoneNumber: jsonData['phoneNumber'],
      phoneNumVerificationCode: jsonData['phoneNumVerificationCode'],
      phoneNumVerificationCodeExpiration: jsonData['phoneNumVerificationCodeExpiration'],
    );}else{
      throw ArgumentError('Invalid JSON data');
    }
  }
}

class ProfilePicture {
  ProfilePicture({
    this.url,
    this.publicId,
  });

  final String? url;
  final String? publicId;

  factory ProfilePicture.fromJson(jsonData) {
    return ProfilePicture(
      url: jsonData['url'],
      publicId: jsonData['publicId'],
    );
  }
}

// class OffersId{
//   OffersId({
//     this.count,
//   });
//   final String? count;
//
//   factory OffersId.fromJson(jsonData) {
//     return OffersId(
//       count: jsonData['offers'],
//     );
//   }
// }
class OfferDetails {
  OfferDetails({
    this.offerId,
    this.taskerId,
    this.taskId,
    this.price,
    this.status,
    this.message,
    this.createdAt,
    this.updatedAt,

  });
  final String? offerId;
  final TaskerId? taskerId;
  final String? taskId;
  final int? price;
  final String? status;
  final String? message;
  final String? createdAt;
  final String? updatedAt;

  factory OfferDetails.fromJson(jsonData) {
    return OfferDetails(
      offerId: jsonData['_id'],
      taskerId: TaskerId.fromJson(jsonData['taskerId']),
      taskId: jsonData['taskId'],
      price: jsonData['price'],
      status: jsonData['status'],
      message: jsonData['message'],
      createdAt: jsonData['createdAt'],
      updatedAt: jsonData['updatedAt'],
    );
  }
}

class TaskerId{
  TaskerId({
    this.id,
    this.userId,
    this.ratingAverage,
    this.ratingQuantity,
  });
  final String? id;
  final UserId? userId;
   var ratingAverage;
   var ratingQuantity;


  factory TaskerId.fromJson(jsonData) {
    return TaskerId(
      id: jsonData['_id'],
      userId: UserId.fromJson(jsonData['userId'],),
      ratingAverage: jsonData['ratingAverage'] ,
      ratingQuantity: jsonData['ratingQuantity'] ,
    );
  }
}




class TaskImages{
  TaskImages({
    this.url,
    this.publicId,
    this.id,
  });
  final String? url;
  final String? publicId;
  final String? id;

  factory TaskImages.fromJson(jsonData) {
    return TaskImages(
      url: jsonData['url'],
      publicId: jsonData['publicId'],
      id: jsonData['_id'],
    );
  }
}