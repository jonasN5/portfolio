import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:portfolio/resources/keys.dart';
import 'package:portfolio/resources/strings.dart';
import 'package:portfolio/services/navigation/delegate.dart';
import 'package:portfolio/services/navigation/pages.dart';
import 'package:portfolio/services/service_locator.dart';
import 'package:portfolio/widgets/hover_animated_button.dart';

/// Individual widget representing this portfolio project, used in
/// [ProjectsScreen].
class PortfolioCard extends StatefulWidget {
  const PortfolioCard({Key? key}) : super(key: key);

  @override
  _PortfolioCardState createState() => _PortfolioCardState();
}

class _PortfolioCardState extends State<PortfolioCard> with TickerProviderStateMixin {
  late AnimationController _sizeControllerText;
  late AnimationController _sizeControllerDetails;

  late Animation<double> _sizeAnimationText;
  late Animation<double> _sizeAnimationDetails;

  @override
  void initState() {
    super.initState();
    setupAnimations();
  }

  /// Setup all animation controllers and animations.
  void setupAnimations() {
    _sizeControllerText =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _sizeControllerDetails =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _sizeAnimationText = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(parent: _sizeControllerText, curve: Curves.ease));
    _sizeAnimationDetails = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _sizeControllerDetails, curve: Curves.ease));
  }

  /// Triggered when the mouse enters the project image region. Starts the
  /// appropriate animations.
  void onHoverEnter() {
    _sizeControllerText
        .forward()
        .then((value) => _sizeControllerDetails.forward());
  }

  /// Triggered when the mouse exits the project image region. Reverses the
  /// appropriate animations.
  void onHoverExit() {
    _sizeControllerDetails
        .reverse()
        .then((value) => _sizeControllerText.reverse());
  }

  /// Triggered when tapping the view details button (web) on the project image
  /// (mobile) where hovering does not work.
  void onTap() {
    serviceLocator<NavigationService>()
        .popToTopOrPush(NavigationPage.projectsPortfolio());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MouseRegion(
          onEnter: (_) => onHoverEnter(),
          onExit: (_) => onHoverExit(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ScaleTransition(
                scale: _sizeAnimationDetails,
                child: HoverAnimatedButton(
                    key: Key(AppKeys.view_details_portfolio_button),
                    onPressed: onTap,
                    child: Text(AppStrings.view_details.tr())),
              ),
              ScaleTransition(
                  scale: _sizeAnimationText,
                  child: GestureDetector(
                    onTap: onTap,
                    child: Padding(
                      padding: EdgeInsets.all(kIsWeb ? 32 : 0),
                      child: Text(
                        "this",
                        style:
                            TextStyle(color: Colors.deepOrange, fontSize: 80),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _sizeControllerText.dispose();
    _sizeControllerDetails.dispose();
    super.dispose();
  }
}
