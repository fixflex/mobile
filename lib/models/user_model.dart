class UserDataModel {
  UserDataModel({
    required this.uId,
    required this.FirstName,
    required this.LastName,
    required this.email,
    required this.emailVerified,
    this.profilePicture,
    required this.role,
    required this.active,
    required this.phoneNumVerified,
    this.createdAt,
    this.updatedAt,
    this.phoneNumber,
    this.phoneNumVerificationCode,
    this.phoneNumVerificationCodeExpiration,
  });

  final String uId;
  final String FirstName;
  final String LastName;
  final String email;
  final bool emailVerified;
  final ProfilePictureModel? profilePicture;
  final String role;
  final bool active;
  final bool phoneNumVerified;
  final String? createdAt;
  final String? updatedAt;
  final String? phoneNumber;
  final String? phoneNumVerificationCode;
  final String? phoneNumVerificationCodeExpiration;

  factory UserDataModel.fromJson(jsonData) {
    return UserDataModel(
      uId: jsonData['_id'],
      FirstName: jsonData['firstName'],
      LastName: jsonData['lastName'],
      email: jsonData['email'],
      emailVerified: jsonData['emailVerified'],
      profilePicture: ProfilePictureModel.fromJson(jsonData['profilePicture']),
      role: jsonData['role'],
      active: jsonData['active'],
      phoneNumVerified: jsonData['phoneNumVerified'],
      createdAt: jsonData['createdAt'],
      updatedAt: jsonData['updatedAt'],
      phoneNumber: jsonData['phoneNumber'],
      phoneNumVerificationCode: jsonData['phoneNumVerificationCode'],
      phoneNumVerificationCodeExpiration: jsonData['phoneNumVerificationCodeExpiration'],
    );
  }
}

class ProfilePictureModel{
  ProfilePictureModel({
    this.url,
    this.publicId,
  });

  final String? url;
  final String? publicId;

  factory ProfilePictureModel.fromJson(jsonData) {
    return ProfilePictureModel(
      url: jsonData['url'],
      publicId: jsonData['publicId'],
    );
  }
}