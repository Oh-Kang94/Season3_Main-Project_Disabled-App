class AddressDepthServerModel {
  final String code;
  final String name;
  bool isSelected; // 선택 상태를 나타내는 필드 추가

  AddressDepthServerModel({
    required this.code,
    required this.name,
    this.isSelected = false,
  });

  factory AddressDepthServerModel.fromJson(Map<String, dynamic> json) {
    return AddressDepthServerModel(
      code: json['cd'] as String,
      name: json['addr_name'] as String,
    );
  }
}
