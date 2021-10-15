import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:portfolio/resources/keys.dart';
import 'package:portfolio/resources/strings.dart';
import 'package:portfolio/services/navigation/delegate.dart';
import 'package:portfolio/services/navigation/pages.dart';
import 'package:portfolio/services/service_locator.dart';
import 'package:portfolio/utils/extensions.dart';
import 'package:portfolio/ui/common/components/drawer.dart';
import 'package:portfolio/widgets/hover_animated_button.dart';
import 'package:portfolio/widgets/language_selector.dart';
import 'package:portfolio/widgets/responsive_layout.dart';

/// Root widget for every screen containing the [AppBar] in a responsive way.
/// Another option would have been to use a single screen with tabs to allow
/// smoother animations between the buttons.
class RootWidget extends StatelessWidget {
  final Widget body;

  const RootWidget({Key? key, required this.body}) : super(key: key);

  void onPressed(AppPage page) =>
      serviceLocator<NavigationService>().popToTopOrPush(page);

  /// Override font sizes if the screen size is small. We can do this here since
  /// this widget is share across all screens. Another viable option would be to
  /// wrap the MaterialApp inside an AnimatedBuilder that listens to a controller.
  ThemeData getThemeData(BuildContext context) =>
      context.isMobile
          ? Theme.of(context).copyWith(
              inputDecorationTheme: Theme.of(context)
                  .inputDecorationTheme
                  .copyWith(
                      errorStyle: Theme.of(context)
                          .inputDecorationTheme
                          .errorStyle!
                          .copyWith(fontSize: 12)),
              textTheme: Theme.of(context).textTheme.copyWith(
                  bodyText2: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 14),
                  subtitle1: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 14)))
          : Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: getThemeData(context),
      child: ResponsiveLayout(
          mobile: Scaffold(
            drawer: MainDrawer(),
            appBar: AppBar(
              title: Text(serviceLocator<NavigationService>()
                  .currentConfiguration
                  .title
                  .tr()
                  .capitalize()),
              actions: [LanguageSelector(compactDisplay: true)],
            ),
            body: body,
          ),
          desktop: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  HoverAnimatedButton(
                      key: Key(AppKeys.about_me_button),
                      onPressed: () => onPressed(NavigationPage.about()),
                      child: Text(AppStrings.about_me.tr().capitalize())),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: HoverAnimatedButton(
                          key: Key(AppKeys.projects_button),
                          onPressed: () => onPressed(NavigationPage.projects()),
                          child: Text(AppStrings.projects.tr().capitalize()))),
                  HoverAnimatedButton(
                      key: Key(AppKeys.contact_button),
                      onPressed: () => onPressed(NavigationPage.contact()),
                      child: Text(AppStrings.contact.tr().capitalize())),
                ],
              ),
              actions: [LanguageSelector(compactDisplay: false)],
            ),
            body: body,
          )),
    );
  }
}
