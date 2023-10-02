class RegexForm {
  static final RegExp idpwRegExp = RegExp(r'^[a-z0-9]{1,8}$');
  static final RegExp nameRegExp = RegExp(r'^[ㄱ-ㅎ가-힣]{2,}$');
  static final RegExp emailRegExp =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  static final RegExp phoneRegExp = RegExp(r'^[0-9]{11}$');
}
