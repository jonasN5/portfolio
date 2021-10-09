import 'package:flutter/widgets.dart';
import 'package:portfolio/services/navigation/pages.dart';

/// The mandatory [RouteInformationParser] for Navigation 2.0.
class AppRouterInformationParser<T> extends RouteInformationParser<AppPage> {
  @override
  Future<AppPage> parseRouteInformation(
      RouteInformation routeInformation) async {
    if (routeInformation.location == null) {
      return NavigationPage.notFound();
    }

    final uri = Uri.parse(routeInformation.location!);
    final pathSegments = uri.pathSegments.toList();

    return AppPage.fromPathSegments(pathSegments);
  }

  @override
  RouteInformation restoreRouteInformation(AppPage configuration) =>
      RouteInformation(
          location: Uri(pathSegments: configuration.pathSegments).path);
}
