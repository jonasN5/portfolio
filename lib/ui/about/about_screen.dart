import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/resources/keys.dart';
import 'package:portfolio/resources/strings.dart';
import 'package:portfolio/ui/common/root.dart';
import 'package:portfolio/widgets/fade_in_image.dart';
import 'package:portfolio/widgets/max_width_container.dart';
import 'package:portfolio/resources/style.dart';

/// The "about-me" screen.
class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RootWidget(
        body: SingleChildScrollView(
      child: MaxWidthContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  /// Avatar
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: ClipOval(
                        child: AssetFadeInImage(
                            key: Key(AppKeys.avatar),
                            assetName: "assets/images/avatar.jpg",
                            width: 160)),
                  ),

                  /// Text
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                    child: Text(AppStrings.about_me_short.tr(),
                        textAlign: TextAlign.center,
                        style: AppStyle.getTitleStyle(context)
                            .copyWith(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(AppStrings.about_me_text.tr(),
                        textAlign: TextAlign.justify),
                  ),

                  /// Tech label and images.
                  Padding(
                    padding: const EdgeInsets.only(top: 96, bottom: 16),
                    child: Text(AppStrings.favorite_techs.tr()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                      width: 640,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset('assets/logos/python.svg',
                              color: Colors.white, height: 32),
                          SvgPicture.asset('assets/logos/flutter.svg',
                              color: Colors.white, height: 32),
                          SvgPicture.asset('assets/logos/android.svg',
                              height: 32),
                          SvgPicture.asset('assets/logos/django.svg',
                              color: Colors.white, height: 32),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
