class ApiEndPoints {
  static const String baseurl = 'http://www.oh-kang.kro.kr:3000/';
  static _ApiEndPoints apiEndPoints = _ApiEndPoints();
}

class _ApiEndPoints {
  final String loginid = 'authaccount/login';
  final String registerid = 'authaccount/registration';
  final String getpicPath = 'authaccount/getpic';
}
