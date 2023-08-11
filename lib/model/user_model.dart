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
  String? googleid;

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
    this.googleid,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      password: json['password'],
      name: json['name'],
      avatar: json['avatar'],
      email: json['email'],
      phone: json['phone'],
      gender: json['gender'],
      disability: json['disability'],
      address: json['address'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      birth: json['birth'],
      kakaoid: json['kakaoid'],
      googleid: json['googleid'],
    );
  }

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
      'googleid': googleid,
    };
  }
}
