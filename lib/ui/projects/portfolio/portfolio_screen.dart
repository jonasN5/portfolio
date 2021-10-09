import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:portfolio/resources/custom_icons.dart';
import 'package:portfolio/resources/keys.dart';
import 'package:portfolio/resources/strings.dart';
import 'package:portfolio/services/navigation/delegate.dart';
import 'package:portfolio/services/service_locator.dart';
import 'package:portfolio/widgets/hover_animated_button.dart';
import 'package:portfolio/utils/extensions.dart';

/// Details screen for the portfolio project. Its structure is currently only
/// meant to be used in a [ModalRoute].
class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: Key(AppKeys.portfolio_project),
      onTap: () => serviceLocator<NavigationService>().pop(),
      child: Material(
        color: Colors.black.withAlpha(50),
        child: Center(
          child: Container(
            width: 300,
            child: Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Hero(
                        tag: "Portfolio",
                        child: Material(
                            color: Colors.transparent,
                            child: Text("Portfolio", style: TextStyle(fontSize: Theme.of(context).textTheme.headline5!.fontSize)))),
                    Padding(
                      padding: const EdgeInsets.only(top: 32, bottom: 16),
                      child: Text(AppStrings.portfolio_description.tr()),
                    ),
                    Center(
                      child: HoverAnimatedButton(
                          onPressed: () =>
                              "https://github.com/themadmrj/portfolio"
                                  .openURL(),
                          child: Text("Github"),
                          icon: Icon(CustomIcons.github_circled)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
