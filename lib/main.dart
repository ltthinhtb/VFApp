import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/services/api/api_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'common/app_themes.dart';
import 'router/route_config.dart';
import 'services/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /// AWAIT SERVICES INITIALIZATION.
  await initServices();

  runApp(const MyApp());
}

/// Is a smart move to make your Services intiialize before you run the Flutter app.
/// as you can control the execution flow (maybe you need to load some Theme configuration,
/// apiKey, language defined by the User... so load SettingService before running ApiService.
/// so GetMaterialApp() doesnt have to rebuild, and takes the values directly.
Future initServices() async {
  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.
  await Get.putAsync(() => ApiService().init());
  await Get.putAsync(() => StoreService().init());
  await Get.putAsync(() => CacheService().init());
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => SettingService().init());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.light,
        initialRoute: RouteConfig.login,
        getPages: RouteConfig.getPages,
        builder: EasyLoading.init(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          S.delegate,
        ],
        locale: Get.find<SettingService>().currentLocate.value,
        supportedLocales: S.delegate.supportedLocales,
      ),
    );
  }

  void hideKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
