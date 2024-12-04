import 'package:dummy_1/controller/splash_controller.dart';
import 'package:dummy_1/utils/app_data.dart';
import 'package:dummy_1/utils/exports.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AppData.init();
  dependencies();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    const MyApp().onTap(
      () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'China Town',
          initialRoute: Routes.splashScreen,
          getPages: Routes.routes,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear((1.0))),
              child: child!,
            );
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

void dependencies() {
  Get.put(() => SplashController(), permanent: true);
  Get.put(() => HomeController(), permanent: true);
  Get.put(() => LoginController(), permanent: true);
  Get.lazyPut(() => SignUpcontroller(), fenix: true);
  Get.lazyPut(() => UserDetailsController(), fenix: true);
}
