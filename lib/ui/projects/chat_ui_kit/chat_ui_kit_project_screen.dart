import 'dart:math';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:portfolio/resources/keys.dart';
import 'package:video_player/video_player.dart';
import 'package:portfolio/resources/custom_icons.dart';
import 'package:portfolio/resources/strings.dart';
import 'package:portfolio/ui/common/root.dart';
import 'package:portfolio/widgets/hover_animated_button.dart';
import 'package:portfolio/widgets/max_width_container.dart';
import 'package:portfolio/utils/extensions.dart';

/// Details screen for the chat ui kit project.
class ChatUiKitProjectScreen extends StatefulWidget {
  const ChatUiKitProjectScreen({Key? key}) : super(key: key);

  @override
  _ChatUiKitProjectScreenState createState() => _ChatUiKitProjectScreenState();
}

class _ChatUiKitProjectScreenState extends State<ChatUiKitProjectScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset("assets/videos/chat_ui_kit.mp4")
      ..setLooping(true)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized
        // even before the play button has been pressed.
        setState(() {
          _controller.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return RootWidget(
        key: Key(AppKeys.chat_ui_kit_project),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              _controller.value.isInitialized
                  ? Container(
                      height: max(400, MediaQuery.of(context).size.width / 2.5),
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    )
                  : Container(
                      height: max(400, MediaQuery.of(context).size.width / 2.5),
                      child: Center(
                          child: Container(
                              height: 40,
                              width: 40,
                              child: CircularProgressIndicator())),
                    ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  width: 600,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HoverAnimatedButton(
                          onPressed: () =>
                              "https://github.com/themadmrj/chat_ui_kit"
                                  .openURL(),
                          child: Text("Github"),
                          icon: Icon(CustomIcons.github_circled)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: MaxWidthContainer(
                    child: Text(
                  AppStrings.chat_ui_kit_description.tr(),
                  textAlign: TextAlign.justify,
                )),
              ),
              Container(height: 80)
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
