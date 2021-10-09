import 'package:get_it/get_it.dart';
import 'package:portfolio/services/locale_manager.dart';
import 'package:portfolio/services/navigation/delegate.dart';
import 'package:portfolio/services/navigation/pages.dart';

// Global variable
GetIt serviceLocator = GetIt.instance;

/// [setupServiceLocator] should always be called in main.dart, before building
/// the app. Registers all necessary instances as singletons. Call the instance
/// using serviceLocator<InstanceClass>().
Future<void> setupServiceLocator() async {
  /// Track Locale and allow dynamic rebuild
  serviceLocator.registerSingleton<LocaleManager>(LocaleManager());

  /// Navigation
  serviceLocator.registerSingleton<NavigationService>(
      NavigationService(initialPage: NavigationPage.about()));
}
