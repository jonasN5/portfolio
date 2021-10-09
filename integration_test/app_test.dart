import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:portfolio/main.dart' as app;
import 'package:portfolio/resources/keys.dart';
import 'package:portfolio/ui/projects/components/project_card_root.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  /// The navigation integration tests will ensure all screens are accessible
  /// as expected and display without errors (pixels out of bounds error would
  /// also be caught).
  /// We also test localization.
  group('end-to-end test', () {
    testWidgets('Test navigation', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      /// Test navigation
      // The first screen we see should be the about screen.
      expect(find.byKey(Key(AppKeys.avatar)), findsOneWidget);

      // Navigate to contact screen
      await tester.tap(find.byKey(Key(AppKeys.contact_button)));
      await tester.pumpAndSettle();
      expect(find.byKey(Key(AppKeys.message_form_field)), findsOneWidget);

      // Navigate to projects screen
      await tester.tap(find.byKey(Key(AppKeys.projects_button)));
      await tester.pumpAndSettle();
      expect(find.byType(ProjectCardRoot), findsNWidgets(3));

      // Navigate to zappr project
      await tester.tap(find.byKey(Key(AppKeys.view_details_zappr_button)));
      await tester.pumpAndSettle();
      expect(find.byType(CarouselSlider), findsOneWidget);

      // Navigate back to projects screen
      await tester.tap(find.byKey(Key(AppKeys.projects_button)));
      await tester.pumpAndSettle();
      // Navigate to chat ui kit screen
      await tester.tap(find.byKey(Key(AppKeys.view_details_chat_kit_button)));
      // We don't pump and settle since there is an infinite progress indicator.
      await tester.pump(Duration(milliseconds: 500));
      expect(find.byKey(Key(AppKeys.chat_ui_kit_project)), findsOneWidget);

      // Navigate back to projects screen
      await tester.tap(find.byKey(Key(AppKeys.projects_button)));
      await tester.pumpAndSettle();
      // Navigate to portfolio screen
      await tester.tap(find.byKey(Key(AppKeys.view_details_portfolio_button)));
      await tester.pumpAndSettle();
      expect(find.byKey(Key(AppKeys.portfolio_project)), findsOneWidget);

      // Tap somewhere to close the portfolio screen
      await tester.tap(find.byKey(Key(AppKeys.portfolio_project)));
      await tester.pumpAndSettle();
      expect(find.byKey(Key(AppKeys.portfolio_project)), findsNothing);

      /// Test localization
      // Navigate back to about screen
      await tester.tap(find.byKey(Key(AppKeys.about_me_button)));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key(AppKeys.language_selector)));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Deutsch').last);
      await tester.pumpAndSettle();
      expect(find.textContaining('Ich bin Jonas'), findsOneWidget);
    });
  });
}
