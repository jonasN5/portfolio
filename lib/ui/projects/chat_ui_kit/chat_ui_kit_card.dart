import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:portfolio/resources/keys.dart';
import 'package:portfolio/resources/strings.dart';
import 'package:portfolio/services/navigation/delegate.dart';
import 'package:portfolio/services/navigation/pages.dart';
import 'package:portfolio/services/service_locator.dart';
import 'package:portfolio/widgets/hover_animated_button.dart';
import 'package:portfolio/widgets/mobile_screen.dart';

/// Individual widget representing the chat ui kit project, used in
/// [ProjectsScreen].
class ChatUiKitCard extends StatefulWidget {

  const ChatUiKitCard({Key? key}) : super(key: key);

  @override
  _ChatUiKitCardState createState() => _ChatUiKitCardState();
}

class _ChatUiKitCardState extends State<ChatUiKitCard> with SingleTickerProviderStateMixin {
  late AnimationController _imagePositionController;

  late Animation<Offset> _imagePositionAnimation;
  late Animation<double> _imageFadeAnimation;

  @override
  void initState() {
    super.initState();
    setupAnimations();
  }

  /// Setup all animation controllers and animations.
  void setupAnimations() {
    _imagePositionController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _imagePositionAnimation =
        Tween<Offset>(begin: Offset.zero, end: Offset(-2.0, 0)).animate(
            CurvedAnimation(
                parent: _imagePositionController, curve: Curves.decelerate));
    _imageFadeAnimation =
        Tween<double>(begin: 1, end: 0).animate(_imagePositionController);
  }

  /// Triggered when the mouse enters the project container region. Starts the
  /// appropriate animations.
  void onHoverEnter() {
    _imagePositionController.forward();
  }

  /// Triggered when the mouse exits the project container region. Reverses the
  /// appropriate animations.
  void onHoverExit() {
    _imagePositionController.reverse();
  }

  void onTap() {
    serviceLocator<NavigationService>()
        .popToTopOrPush(NavigationPage.projectsChatUiKit());
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onHoverEnter(),
      onExit: (_) => onHoverExit(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          HoverAnimatedButton(
              key: Key(AppKeys.view_details_chat_kit_button),
              onPressed: onTap,
              child: Text(AppStrings.view_details.tr())),
          FadeTransition(
            opacity: _imageFadeAnimation,
            child: SlideTransition(
                position: _imagePositionAnimation,
                child: GestureDetector(
                  onTap: onTap,
                  child: MobileScreen(
                      imageAsset: "assets/images/chat_ui_kit/chat_ui_kit_main.webp",
                      width: (MediaQuery.of(context).size.width/3).clamp(0, 200).toDouble()),
                )),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _imagePositionController.dispose();
    super.dispose();
  }
}
