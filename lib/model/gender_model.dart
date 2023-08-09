class GenderModel {
  String name;

  GenderModel(this.name);

  @override
  String toString() {
    return name;
  }
}

List<GenderModel> genders = [
  GenderModel('남자'),
  GenderModel('여자'),
];
