import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracking_app/core/utils/string_manager.dart';
import 'package:tracking_app/ui/success_page/view/success_page.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  // 👇 ضروري لتفادي MissingPluginException
  SharedPreferences.setMockInitialValues({});

  await EasyLocalization.ensureInitialized();

  group('SuccessPage UI Tests', () {
    testWidgets('should display all UI elements correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('ar')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          startLocale: const Locale('en'),
          child: const MaterialApp(
            home: SuccessPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Assert - Check texts
      expect(find.text(AppStrings.thankYou.tr()), findsOneWidget);
      expect(find.text(AppStrings.theOrderDeliveredSuccessfully.tr()), findsOneWidget);
      expect(find.text(AppStrings.done.tr()), findsOneWidget);

      // Assert - Check icon and avatars
      expect(find.byIcon(Icons.check_rounded), findsOneWidget);
      expect(find.byType(CircleAvatar), findsNWidgets(4));
    });
  });
}
