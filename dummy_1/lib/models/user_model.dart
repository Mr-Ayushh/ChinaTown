class UserModel {
  String? uid;
  String? userId;
  String? name;
  String? address;
  String? pincode;
  String? email;
  String? phone;
  bool isFirstTime = true;
  String? profilePicPath;

  UserModel(
      {this.uid,
      this.userId,
      this.name,
      this.address,
      this.pincode,
      this.email,
      this.phone,
      this.isFirstTime = true,
      this.profilePicPath});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      userId: map['userId'],
      name: map['name'],
      address: map['address'],
      pincode: map['pincode'],
      email: map['email'],
      phone: map['phone'],
      isFirstTime: map['isFirstTime'] ?? true,
      profilePicPath: map['profilePicPath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'userId': userId,
      'name': name,
      'address': address,
      'pincode': pincode,
      'email': email,
      'phone': phone,
      'isFirstTime': isFirstTime,
      'profilePicPath': profilePicPath,
    };
  }
}
