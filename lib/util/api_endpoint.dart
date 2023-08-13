class ApiEndPoints {
  static const String baseurl = 'http://www.oh-kang.kro.kr:7288/';
  static _ApiEndPoints apiEndPoints = _ApiEndPoints();
}

class _ApiEndPoints {
  final String loginid = 'login/login';
  final String checkkakao = 'login/checkKaKaoEnrolled';
  final String checkgoogle = 'login/checkGoogleEnrolled';
  final String getpicPath = 'login/getpic';
  final String registerid = 'register/registration';
  final String getUser = 'register/getuser';
  final String updateUser = 'register/updateuser';
  final String withdrawal = 'register/withdrawal';

  final String map = 'map/';

  final String sendemail = 'mail/sendemail';
  final String findId = 'mail/findId';
  final String verifycode = 'mail/verifycode';

  final String ai_test = 'test';
}
