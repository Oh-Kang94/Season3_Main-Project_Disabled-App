class DisabledModel {
  final String name;

  DisabledModel(this.name);

  @override
  String toString() {
    return name;
  }
}

List<DisabledModel> disabilities = [
  DisabledModel('시각 장애 중증'),
  DisabledModel('시각 장애 경증'),
  DisabledModel('청각 장애 경증'),
  DisabledModel('청각 장애 중증'),
  DisabledModel('정신 장애 경증'),
  DisabledModel('정신 장애 중증'),
  DisabledModel('지체 장애 경증'),
  DisabledModel('지체 장애 중증'),
  DisabledModel('지적 장애 경증'),
  DisabledModel('지적 장애 중증'),
];
