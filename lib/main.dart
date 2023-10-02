import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:season3_team1_mainproject/util/theme.dart';
import 'package:season3_team1_mainproject/view/register/change_user.dart';
import 'package:season3_team1_mainproject/view/splash.dart';
import 'package:season3_team1_mainproject/vm/home_ctrl.dart';
import 'package:season3_team1_mainproject/vm/login_ctrl.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(); // .env 파일 로드
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Get.put(HomeController());
  Get.put(LoginController());
  KakaoSdk.init(
    nativeAppKey: dotenv.env["KAKAO_NATIVE_APP_KEY"],
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          themeMode: ThemeMode.light,
          theme: CustomTheme.lighttheme,
          darkTheme: CustomTheme.darktheme,
          // 언어 지원
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ko', ''),
            Locale('en', ''),
          ],
          // 초기 시작 값
          initialRoute: '/',
          getPages: [
            GetPage(
              name: '/',
              page: () => const SplashScreen(),
            ),
            GetPage(
              name: '/Editing',
              page: () => const ChangeUser(),
            ),
          ],
        );
      },
    );
  }
}
