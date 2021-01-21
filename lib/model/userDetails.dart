import 'dart:typed_data';

class UserDetails {
  int id;
  String userName;
  Uint8List profilePicture;
  static final columns = [
    "id",
    "username",
    "profilepicture",
  ];

  UserDetails({this.id, this.userName, this.profilePicture});

  factory UserDetails.fromMap(Map<String, dynamic> data) {
    return UserDetails(
      id: data['id'],
      userName: data['username'],
      profilePicture: data['profilepicture'],
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": userName,
        "profilepicture": profilePicture,
      };
}
