class UserData {
  String id;
  String password;
  String name;
  String avatar;
  String email;
  String phone;
  String gender;
  String disability;
  String address;
  double latitude;
  double longitude;
  String birth;
  String? kakaoid;

  UserData({
    required this.id,
    required this.password,
    required this.name,
    required this.avatar,
    required this.email,
    required this.phone,
    required this.gender,
    required this.disability,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.birth,
    this.kakaoid,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'password': password,
      'name': name,
      'avatar': avatar,
      'email': email,
      'phone': phone,
      'gender': gender,
      'disability': disability,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'birth': birth,
      'kakaoid': kakaoid,
    };
  }
}
