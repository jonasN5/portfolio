import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:portfolio/resources/strings.dart';
import 'package:portfolio/ui/common/root.dart';
import 'package:portfolio/ui/projects/chat_ui_kit/chat_ui_kit_card.dart';
import 'package:portfolio/ui/projects/components/project_card_root.dart';
import 'package:portfolio/ui/projects/portfolio/portfolio_card.dart';
import 'package:portfolio/ui/projects/zappr/zappr_card.dart';

/// Root screen listing all projects.
class ProjectsScreen extends StatelessWidget {
  ProjectsScreen({Key? key}) : super(key: key);

  final ValueNotifier<bool> _onZapprEnterAnimationEnd =
      ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return RootWidget(
        body: SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: ValueListenableBuilder(
              valueListenable: _onZapprEnterAnimationEnd,
              builder: (context, bool hasEnded, _) {
                return ProjectCardRoot(
                    child: ZapprCard(visibleLogo: hasEnded),
                    labels: [AppStrings.published.tr()],
                    title: "Zappr",
                    onEnterAnimationEnd: () =>
                        _onZapprEnterAnimationEnd.value = true);
              }),
        ),
        ProjectCardRoot(
            runEnterAnimationOnVisibility: true,
            child: ChatUiKitCard(),
            labels: [AppStrings.library],
            title: "Chat Ui Kit"),
        Container(height: 16),
        ProjectCardRoot(
            runEnterAnimationOnVisibility: true,
            child: PortfolioCard(),
            title: "Portfolio")
      ]),
    ));
  }
}
