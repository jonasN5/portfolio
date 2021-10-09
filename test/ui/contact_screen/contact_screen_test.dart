import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:portfolio/main.dart' as app;
import 'package:portfolio/resources/constants.dart';
import 'package:portfolio/resources/keys.dart';
import 'package:portfolio/ui/contact/contact_screen.dart';
import 'package:portfolio/ui/contact/contact_viewmodel.dart';
import 'package:progress_state_button/progress_button.dart';

import 'contact_screen_test.mocks.dart';

@GenerateMocks([ContactViewModel])
void main() {
  /// also fake send message and check UI update
  ///
  group('Contact screen tests', () {
    testWidgets('Tests form fields and validation',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to contact screen
      await tester.tap(find.byKey(Key(AppKeys.contact_button)));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).at(0), "testUserName");
      await tester.enterText(find.byType(TextFormField).at(2), "test message");
      // Invalid email should be blocked
      await tester.enterText(find.byType(TextFormField).at(1), "testemail");
      await tester.tap(find.byType(ProgressButton));
      await tester.pumpAndSettle();
      expect(find.text('Invalid email'), findsOneWidget);

      // Empty fields should display 3 required fields
      await tester.enterText(find.byType(TextFormField).at(0), "");
      await tester.enterText(find.byType(TextFormField).at(1), "");
      await tester.enterText(find.byType(TextFormField).at(2), "");
      await tester.tap(find.byType(ProgressButton));
      await tester.pumpAndSettle();
      expect(find.textContaining('required'), findsNWidgets(3));
    });

    testWidgets('Message request status should update UI accordingly',
        (WidgetTester tester) async {
      final mockModel = MockContactViewModel();

      await tester.pumpWidget(EasyLocalization(
          supportedLocales: AppConstants.SUPPORTED_LOCALES,
          path: AppConstants.LOCALIZATION_ASSET_PATH,
          startLocale: AppConstants.SUPPORTED_LOCALES[0],
          fallbackLocale: AppConstants.SUPPORTED_LOCALES[0],
          useOnlyLangCode: true,
          child: MaterialApp(
              home: Scaffold(body: ContactScreen(model: mockModel)))));

      // Enter valid information to pass validation
      await tester.enterText(find.byType(TextFormField).at(0), "testUserName");
      await tester.enterText(
          find.byType(TextFormField).at(1), "testemail@gmail.com");
      await tester.enterText(find.byType(TextFormField).at(2), "test message");

      // Expect a success icon in the UI when the call succeeds
      when(mockModel.sendMessage()).thenAnswer((_) => Future.value());
      await tester.tap(find.byType(ProgressButton));
      await tester.pump(Duration(milliseconds: 500));
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      // Settle until Future.delayed is over
      await tester.pumpAndSettle(Duration(milliseconds: 500));

      // Expect a failed icon in the UI when the call succeeds
      when(mockModel.sendMessage()).thenAnswer((_) => Future.error(""));
      await tester.tap(find.byType(ProgressButton));
      await tester.pump(Duration(milliseconds: 500));
      expect(find.byIcon(Icons.cancel), findsOneWidget);
      // Settle until Future.delayed is over
      await tester.pumpAndSettle(Duration(milliseconds: 500));
    });
  });
}
