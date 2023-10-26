import 'package:dogs_app/app/app.bottomsheets.dart';
import 'package:dogs_app/app/app.locator.dart';
import 'package:dogs_app/app/app.router.dart';
import 'package:dogs_app/ui/common/theme_class.dart';
import 'package:dogs_app/ui/views/dogs/dogs_view.dart';
import 'package:flutter/material.dart';
import 'package:dogs_app/ui/common/app_colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupBottomSheetUi();

  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // Todo This should be used in the future.
  //final _appLifecycleObserver = locator<AppLifecycleObserver>();
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Todo This should be used in the future.
  /// This overriden function helps to observe the life cycle of the app
  /// We need to refresh the view when the app has been resumed from the
  /// background
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // _appLifecycleObserver
      //     .setAppResumedState(state == AppLifecycleState.resumed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeClass.lightTheme,
      home: const AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: kcWhite,
          systemNavigationBarColor: kcWhite,
          systemNavigationBarDividerColor: kcWhite,
          systemNavigationBarIconBrightness: Brightness.dark,
          systemStatusBarContrastEnforced: true,
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.dark, // For iOS (dark icons)
        ),
        child: DogsView(),
      ),
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
    );
  }
}
