class MapModel{
  late final int id;
  late final String capacity;
  late final String city;
  late final int isVirtualstation;
  late final double latitude;
  late final double longitude;

  late final String name;
  late final String address;
  late final String seq;
  // late final int zip;
  MapModel({
    required this.id,
    required this.capacity,
    required this.city,
    required this.isVirtualstation,
    required this.latitude,
    required this.longitude,
    
    required this.name,//사업장명
    required this.address,//주소
    required this.seq,//seq
    // required this.zip,
  });
  

  factory MapModel.fromJson(Map<String, dynamic> json){
    return MapModel(
      id: json['id'], 
      capacity: json['capacity'], 
      city: json['city'], 
      isVirtualstation: json['isVirtualstation'], 
      latitude: json['latitude'], 
      longitude: json['longitude'], 
      name: json['name'], 
      address: json['address'], 
      seq: json['seq']);
    // zip = json['zip'];
  }

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'capacity':capacity,
      'city': city,
      'isVirtualstation':isVirtualstation,
      'latitude':latitude,
      'longitude':longitude,
      'name':name,
      'address':address,
      'seq':seq
    };
  }

  
}

class AddressDTO {
  final String mapaddress;

  AddressDTO(this.mapaddress);
}