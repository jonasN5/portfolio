import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:portfolio/resources/strings.dart';
import 'package:portfolio/services/navigation/delegate.dart';
import 'package:portfolio/services/navigation/pages.dart';
import 'package:portfolio/services/service_locator.dart';
import 'package:portfolio/utils/extensions.dart';

part 'drawer.g.dart';

/// The drawer used when the screen size is small.
class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  AppPage? destinationPage;

  void onTap(BuildContext context, AppPage page) {
    Scaffold.of(context).openEndDrawer();
    destinationPage = page;
  }

  @override
  void dispose() {
    if (destinationPage != null)
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        serviceLocator<NavigationService>().popToTopOrPush(destinationPage!);
      });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          child: Column(children: [
        Padding(
          padding: EdgeInsets.only(top: 12),
          child: DrawerRow(Icons.person, AppStrings.about_me.tr().capitalize(),
              () => onTap(context, NavigationPage.about())),
        ),
        DrawerRow(Icons.work, AppStrings.projects.tr().capitalize(),
            () => onTap(context, NavigationPage.projects())),
        DrawerRow(Icons.send, AppStrings.contact.tr().capitalize(),
            () => onTap(context, NavigationPage.contact())),
      ])),
    );
  }
}

@swidget
Widget drawerRow(IconData icon, String text, VoidCallback onTap) {
  return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: 24, top: 12, bottom: 12),
        child: Row(
          children: [
            Padding(padding: EdgeInsets.only(right: 12), child: Icon(icon)),
            Text(text),
          ],
        ),
      ));
}
