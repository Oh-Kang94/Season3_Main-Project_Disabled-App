class ApiEndPoints {
  static const String baseurl = 'http://www.oh-kang.kro.kr:7288/';
  static const String localhost = 'http://localhost:3000/';
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

  final String sendemail = 'mail/email';
  final String verifycode = 'mail/verifycode';

  final String ai_test = 'test';
}
