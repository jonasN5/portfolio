import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:portfolio/resources/keys.dart';
import 'package:portfolio/resources/strings.dart';
import 'package:portfolio/services/navigation/delegate.dart';
import 'package:portfolio/services/navigation/pages.dart';
import 'package:portfolio/services/service_locator.dart';
import 'package:portfolio/widgets/hover_animated_button.dart';
import 'package:portfolio/widgets/mobile_screen.dart';

/// Individual widget representing the Zappr project, used in [ProjectsScreen].
class ZapprCard extends StatefulWidget {
  final bool visibleLogo;

  const ZapprCard({Key? key, this.visibleLogo = false}) : super(key: key);

  @override
  _ZapprCardState createState() => _ZapprCardState();
}

class _ZapprCardState extends State<ZapprCard> with TickerProviderStateMixin {
  late AnimationController _zapprLogoVerticalPositionController;
  late AnimationController _zapprLogoHorizontalPositionController;
  late AnimationController _zapprLogoRotationController;
  late AnimationController _imagePositionController;

  late Animation<Offset> _zapprLogoVerticalPositionAnimation;
  late Animation<Offset> _zapprLogoHorizontalPositionAnimation;
  late Animation<double> _zapprLogoRotationAnimation;

  late Animation<Offset> _imagePositionAnimation;

  @override
  void initState() {
    super.initState();
    setupAnimations();
  }

  /// Setup all animation controllers and animations.
  void setupAnimations() {
    _imagePositionController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _zapprLogoVerticalPositionController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _zapprLogoHorizontalPositionController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _zapprLogoRotationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));

    _zapprLogoVerticalPositionAnimation =
        Tween<Offset>(begin: Offset(5, -10), end: Offset(5, 0)).animate(
            CurvedAnimation(
                parent: _zapprLogoVerticalPositionController,
                curve: Curves.easeIn));
    _zapprLogoHorizontalPositionAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-2, 0)).animate(
            CurvedAnimation(
                parent: _zapprLogoHorizontalPositionController,
                curve: Curves.linear));
    _zapprLogoRotationAnimation =
        Tween<double>(begin: 1, end: 0).animate(_zapprLogoRotationController);

    _imagePositionAnimation =
        Tween<Offset>(begin: Offset.zero, end: Offset(-1.0, 0)).animate(
            CurvedAnimation(
                parent: _imagePositionController, curve: Curves.decelerate));
  }

  /// Triggered when the mouse enters the project container region. Starts the
  /// appropriate animations.
  void onHoverEnter() {
    _zapprLogoVerticalPositionController.reset();
    _zapprLogoHorizontalPositionController.reset();
    _zapprLogoRotationController.reset();
    _imagePositionController.forward().then((value) {
      _zapprLogoVerticalPositionController.forward().then((value) {
        _zapprLogoHorizontalPositionController.forward();
        _zapprLogoRotationController.forward();
      });
    });
  }

  /// Triggered when the mouse exits the project container region. Reverses the
  /// appropriate animations.
  void onHoverExit() {
    _imagePositionController.reverse().then((value) => _zapprLogoVerticalPositionController.reset());
  }

  void onTap() => serviceLocator<NavigationService>()
      .popToTopOrPush(NavigationPage.projectsZappr());

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onHoverEnter(),
      onExit: (_) => onHoverExit(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Visibility(
            visible: widget.visibleLogo,
            child: SlideTransition(
                position: _zapprLogoVerticalPositionAnimation,
                child: SlideTransition(
                  position: _zapprLogoHorizontalPositionAnimation,
                  child: RotationTransition(
                    turns: _zapprLogoRotationAnimation,
                    child: SvgPicture.asset(
                      "assets/logos/zappr_logo.svg",
                      width: 32,
                      height: 32,
                    ),
                  ),
                )),
          ),
          HoverAnimatedButton(
              key: Key(AppKeys.view_details_zappr_button),
              onPressed: onTap,
              child: Text(AppStrings.view_details.tr())),
          GestureDetector(
            onTap: onTap,
            child: SlideTransition(
              position: _imagePositionAnimation,
              child: MobileScreen(
                  imageAsset: "assets/images/zappr/main.webp",
                  width: (MediaQuery.of(context).size.width / 3)
                      .clamp(0, 200)
                      .toDouble()),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _imagePositionController.dispose();
    _zapprLogoVerticalPositionController.dispose();
    _zapprLogoHorizontalPositionController.dispose();
    _zapprLogoRotationController.dispose();
    super.dispose();
  }
}
