class MapModel {
  late final int? id;
  late final String? capacity;
  late final String? city;
  late final int? isVirtualstation;
  late final double? latitude;
  late final double? longitude;

  late final String name;
  late final String address;
  late final int seq;
  // late final int zip;
  MapModel({
    this.id,
    this.capacity,
    this.city,
    this.isVirtualstation,
    this.latitude,
    this.longitude,
    required this.name, //사업장명
    required this.address, //주소
    required this.seq, //seq
    // required this.zip,
  });

  factory MapModel.fromJson(Map<String, dynamic> json) {
    return MapModel(
      id: json['id'],
      capacity: json['capacity'],
      city: json['city'],
      isVirtualstation: json['isVirtualstation'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      name: json['사업장명'], // '사업장명' 필드로 변경
      address: json['주소'], // '주소' 필드로 변경
      seq: json['seq'],
    ); // 'seq' 필드로 변경
    // zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'capacity': capacity,
      'city': city,
      'isVirtualstation': isVirtualstation,
      'latitude': latitude,
      'longitude': longitude,
      'name': name,
      'address': address,
      'seq': seq
    };
  }
}

class AddressDTO {
  final String mapaddress;

  AddressDTO(this.mapaddress);
}
