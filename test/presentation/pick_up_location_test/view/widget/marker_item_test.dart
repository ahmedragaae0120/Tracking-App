import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracking_app/ui/pick_up_location/view/widget/marker_item.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('createCircularMarkerWithIconAndText returns BitmapDescriptor', () async {
    final result = await MarkerItem.createCircularMarkerWithIconAndText(
      iconData: Icons.home_outlined,
      text: 'User',
    );

    expect(result, isA<BitmapDescriptor>());
  });
}
