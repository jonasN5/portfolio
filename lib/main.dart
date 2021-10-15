import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/foundation.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:portfolio/resources/constants.dart';
import 'package:portfolio/resources/colors.dart';
import 'package:portfolio/services/locale_manager.dart';
import 'package:portfolio/services/navigation/delegate.dart';
import 'package:portfolio/services/navigation/parser.dart';
import 'package:portfolio/services/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Here we set the URL strategy for our web app.
  // It is safe to call this function when running on mobile or desktop as well.
  setPathUrlStrategy();

  // Setup logging
  if (kReleaseMode) {
    // Here we would setup a production crash management framework,
    // like Crashlytics and pass all uncaught errors to it.
  } else {
    Fimber.plantTree(DebugTree());
  }

  // Make sure all necessary services are ready (like a database).
  await setupServiceLocator();

  runApp(EasyLocalization(
      supportedLocales: AppConstants.SUPPORTED_LOCALES,
      path: AppConstants.LOCALIZATION_ASSET_PATH,
      startLocale: AppConstants.SUPPORTED_LOCALES[0],
      fallbackLocale: AppConstants.SUPPORTED_LOCALES[0],
      useOnlyLangCode: true,
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  /// We allow passing home here to be able to build MyApp in our tests.
  final Widget? home;

  MyApp({this.home});

  @override
  Widget build(BuildContext context) {
    // If the Locale has changed, rebuild all pages.
    if (serviceLocator<LocaleManager>().hasLocaleChanged) {
      serviceLocator<LocaleManager>().hasLocaleChanged = false;
      serviceLocator<NavigationService>().refreshPages();
    }


    return MaterialApp.router(
      title: 'Portfolio',
      routerDelegate: serviceLocator<NavigationService>(),
      routeInformationParser: AppRouterInformationParser(),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
          fontFamily: 'IBMPlexMono',
          brightness: Brightness.dark,
          inputDecorationTheme: InputDecorationTheme().copyWith(
              errorStyle: TextStyle().copyWith(fontSize: 18)),
          textTheme: TextTheme().copyWith(
              // Globally used
              bodyText2: TextStyle().copyWith(fontSize: 20),
              // Used by the language dropdown button
              subtitle1: TextStyle().copyWith(fontSize: 20)),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  primary: Colors.white, padding: EdgeInsets.all(16))),
          primarySwatch:
              _createMaterialColor(AppColors.DARK_THEME_PRIMARY_COLOR)),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }

  MaterialColor _createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
