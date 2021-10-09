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

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
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
        ));
  }
}
