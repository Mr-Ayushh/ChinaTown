import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testing_user_list_with_api/app/core/theme/app_theme.dart';
import 'package:testing_user_list_with_api/app/presentation/pages/users_list/users_list_page.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/translations/app_translations.dart';
import '../../../core/utils/app_navigator_observer.dart';
import '../../manager/bindings/app_bindings.dart';
import '../../manager/routes/app_pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => GetMaterialApp(
        key: UniqueKey(),
        initialRoute: AppRoutes.INITIAL,
        initialBinding: AppBinding(),
        getPages: AppPages.pages,
        navigatorObservers: [AppNavigatorObserver()],
        translationsKeys: AppTranslation.translations,
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        darkTheme: appThemeData /*ThemeData.dark(useMaterial3: true)*/,
        defaultTransition: Transition.native,
        enableLog: true,
        title: 'Flutter Demo',
        theme: appThemeData,
        themeMode: ThemeMode.system,
        /*ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          useMaterial3: true,
        ),*/

        home: UserListPage(),
      );
}
