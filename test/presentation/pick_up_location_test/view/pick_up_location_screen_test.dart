import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracking_app/ui/pick_up_location/view/pick_up_location_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PickUpLocationScreen UI Tests', () {
    final LatLng clientLocation = const LatLng(37.7749, -122.4194);
    final LatLng driverLocation = const LatLng(37.7849, -122.4094);

    testWidgets('should display GoogleMap', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: PickUpLocationScreen(
            clientLocation: clientLocation,
            driverLocation: driverLocation,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(GoogleMap), findsOneWidget);
    });
  });
}
