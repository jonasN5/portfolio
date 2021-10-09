import 'package:flutter/material.dart';
import 'package:portfolio/resources/strings.dart';
import 'package:portfolio/services/locale_manager.dart';
import 'package:portfolio/services/navigation/modal_page.dart';
import 'package:portfolio/services/navigation/no_transition_page.dart';
import 'package:portfolio/services/navigation/not_found.dart';
import 'package:portfolio/services/service_locator.dart';
import 'package:portfolio/ui/about/about_screen.dart';
import 'package:portfolio/ui/contact/contact_screen.dart';
import 'package:portfolio/ui/projects/projects_screen.dart';
import 'package:portfolio/ui/projects/chat_ui_kit/chat_ui_kit_project_screen.dart';
import 'package:portfolio/ui/projects/portfolio/portfolio_screen.dart';
import 'package:portfolio/ui/projects/zappr/zappr_project_screen.dart';

/// The list of all [Page]s, e.g. routes. To build a new page, simply call
/// final AppPage page = NavigationPage.about() for example.
class NavigationPage {
  static AppPage notFound() => AppPage(key: "not-found", child: NotFound());

  static AppPage about() => AppPage(
      pathSegments: ["about-me"],
      page: NoAnimationPage(
          child: AboutScreen(),
          key: ValueKey(
              "${serviceLocator<LocaleManager>().currentLocale}_about")),
      title: AppStrings.about_me);

  static AppPage projects() => AppPage(
      pathSegments: ["projects"],
      page: NoAnimationPage(
          child: ProjectsScreen(),
          key: ValueKey(
              "${serviceLocator<LocaleManager>().currentLocale}_projects")),
      title: AppStrings.projects);

  static AppPage projectsZappr() => AppPage(
      pathSegments: ["projects", "zappr"],
      page: NoAnimationPage(
          child: ZapprProjectScreen(),
          key: ValueKey(
              "${serviceLocator<LocaleManager>().currentLocale}_projects_zappr")),
      title: "Zappr");

  static AppPage projectsChatUiKit() => AppPage(
      pathSegments: ["projects", "chat-ui-kit"],
      page: NoAnimationPage(
          child: ChatUiKitProjectScreen(),
          key: ValueKey(
              "${serviceLocator<LocaleManager>().currentLocale}_projects_chat_ui_kit")),
      title: "Chat Ui Kit");

  static AppPage projectsPortfolio() => AppPage(
      pathSegments: ["projects", "portfolio"],
      page: ModalNoAnimationPage(
          child: PortfolioScreen(),
          key: ValueKey(
              "${serviceLocator<LocaleManager>().currentLocale}_projects_portfolio")),
      title: "Portfolio");

  static AppPage contact() => AppPage(
      pathSegments: ["contact"],
      page: NoAnimationPage(
          child: ContactScreen(),
          key: ValueKey(
              "${serviceLocator<LocaleManager>().currentLocale}_contact")),
      title: AppStrings.contact);
}

/// Represents a single route. Add a new route to [fromPathSegments] to allow
/// parsing it from the url.
class AppPage {
  /// The key used with [child] to build a [Page].
  String? _key;

  /// The child used with [_key] to build a [Page].
  final Widget? child;

  /// Any parameters the pass when build a [Page].
  final Object? arguments;

  /// The page title that will be displayed in the [AppBar].
  String? _title;

  /// The segments that constitute the page path.
  List<String>? _pathSegments;

  /// The [Page] used instead of [_key] & [child].
  Page? _page;

  AppPage(
      {this.child,
      String? key,
      this.arguments,
      List<String>? pathSegments,
      String? title,
      Page? page})
      : assert((child != null && key != null) || page != null,
            "Either child & key or page must be provided") {
    if (pathSegments != null) _pathSegments = pathSegments;
    if (page != null) _page = page;
    if (title != null) _title = title;
    if (key != null) _key = key;
  }

  Page get page => _page ?? MaterialPage(key: ValueKey(key), child: child!);

  String get key => _key ?? page.key.toString();

  static AppPage fromPathSegments(List<String> pathSegments) {
    if (pathSegments.isEmpty) return NavigationPage.about();
    final root = pathSegments[0];
    switch (root) {
      case "/":
        return NavigationPage.about();
      case "about-me":
        return NavigationPage.about();
      case "projects":
        if (pathSegments.length > 1) {
          if (pathSegments[1] == "zappr") {
            return NavigationPage.projectsZappr();
          } else if (pathSegments[1] == "chat-ui-kit") {
            return NavigationPage.projectsChatUiKit();
          }
        }
        return NavigationPage.projects();
      case "contact":
        return NavigationPage.contact();
      default:
        return NavigationPage.notFound();
    }
  }

  List<String> get pathSegments => _pathSegments ?? [_key.toString()];

  String get title => _title ?? key;
}
