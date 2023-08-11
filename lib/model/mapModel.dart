class MapModel{
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

  MapModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    capacity = json['capacity'];
    city = json['city'];
    isVirtualstation = json['isVirtualstation'];
    latitude = json['latitude'];
    longitude = json['longitude'];

    name = json['name'];
    address = json['address'];
    seq = json['seq'];
    // zip = json['zip'];
  }

  Map<String, dynamic> toJson(){
    final _data = <String, dynamic>{};
    _data['id']= id;
    _data['capacity']= capacity;
    _data['city']= city;
    _data['isVirtualstation']= isVirtualstation;
    _data['latitude']= latitude;
    _data['longitude']= longitude;

    _data['name']= name;
    _data['address']= address;
    _data['seq']=seq;    
    // _data['zip']= zip;
    return _data;
  }

  
}

class AddressDTO {
  final String mapaddress;

  AddressDTO(this.mapaddress);
}