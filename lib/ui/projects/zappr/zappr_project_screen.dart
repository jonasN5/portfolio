import 'dart:math';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:portfolio/resources/custom_icons.dart';
import 'package:portfolio/resources/strings.dart';
import 'package:portfolio/ui/common/root.dart';
import 'package:portfolio/widgets/hover_animated_button.dart';
import 'package:portfolio/widgets/max_width_container.dart';
import 'package:portfolio/widgets/mobile_screen.dart';
import 'package:portfolio/utils/extensions.dart';

/// Details screen for the Zappr project.
class ZapprProjectScreen extends StatefulWidget {
  const ZapprProjectScreen({Key? key}) : super(key: key);

  @override
  _ZapprProjectScreenState createState() => _ZapprProjectScreenState();
}

class _ZapprProjectScreenState extends State<ZapprProjectScreen> {
  static const List<String> imageAssets = [
    "assets/images/zappr/screen_0.webp",
    "assets/images/zappr/screen_1.webp",
    "assets/images/zappr/screen_2.webp",
    "assets/images/zappr/screen_3.webp",
    "assets/images/zappr/screen_4.webp",
  ];

  @override
  Widget build(BuildContext context) {
    final height = max(400, MediaQuery.of(context).size.width / 2.5).toDouble();
    return RootWidget(
        body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
                height: height,
                aspectRatio: 0.46,
                viewportFraction: 0.5,
                enlargeCenterPage: true,
                autoPlay: true),
            items: imageAssets.map((asset) {
              return Builder(
                builder: (BuildContext context) {
                  return MobileScreen(imageAsset: asset);
                },
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: 600,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HoverAnimatedButton(
                      onPressed: () => "https://zappr.app".openURL(),
                      child: Text(AppStrings.website.tr().capitalize()),
                      icon: context.isMobile ? null : Icon(Icons.language)),
                  HoverAnimatedButton(
                      onPressed: () =>
                          "https://play.google.com/store/apps/details?id=com.zappr.android&hl=en"
                              .openURL(),
                      child: Text("Play Store"),
                      icon: context.isMobile ? null : Icon(Icons.android)),
                  HoverAnimatedButton(
                      onPressed: () =>
                          "https://apps.apple.com/gb/app/zappr/id1551794581"
                              .openURL(),
                      child: Text("App Store"),
                      icon: context.isMobile ? null : Icon(CustomIcons.apple))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: MaxWidthContainer(
                child: Text(AppStrings.zappr_description.tr(),
                    textAlign: TextAlign.justify)),
          ),
          Container(height: 80)
        ],
      ),
    ));
  }
}
