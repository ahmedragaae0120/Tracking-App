import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tracking_app/core/utils/colors_manager.dart';

class MarkerItem {
  static Future<BitmapDescriptor> createCircularMarkerWithIconAndText({
    required IconData iconData,
    required String text,
    double size = 100,
    Color backgroundColor = Colors.white,
    Color iconColor = ColorManager.primaryColor,
    Color textColor = ColorManager.white,
  }) async {
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    // تصغير حجم الدائرة
    final double circleRadius = size * 0.35;
    final double circleCenterX = circleRadius + 10;
    final double circleCenterY = size / 2;

    // إعداد النص
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 24,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    );
    textPainter.layout();

    // الحسابات
    final double totalWidth = size + textPainter.width + 30;
    final double totalHeight = size;
    final double borderRadius = 50;

    // رسم الخلفية
    final Paint borderPaint = Paint()
      ..color = ColorManager.primaryColor
      ..style = PaintingStyle.fill;

    final rRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, totalWidth, totalHeight),
      Radius.circular(borderRadius),
    );
    canvas.drawRRect(rRect, borderPaint);

    // رسم الدائرة المصغرة
    final Paint circlePaint = Paint()..color = backgroundColor;
    canvas.drawCircle(Offset(circleCenterX, circleCenterY), circleRadius, circlePaint);

    // رسم الأيقونة داخل الدائرة المصغرة
    final iconPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(iconData.codePoint),
        style: TextStyle(
          fontSize: circleRadius, // تصغير حجم الأيقونة
          fontFamily: iconData.fontFamily,
          package: iconData.fontPackage,
          color: iconColor,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    iconPainter.layout();

    final iconOffset = Offset(
      circleCenterX - iconPainter.width / 2,
      circleCenterY - iconPainter.height / 2,
    );
    iconPainter.paint(canvas, iconOffset);

    // رسم النص على يمين الدائرة
    final textOffset = Offset(
      circleRadius * 2 + 20,
      (size - textPainter.height) / 2,
    );
    textPainter.paint(canvas, textOffset);

    // تحويل إلى صورة
    final image = await recorder.endRecording().toImage(
      totalWidth.toInt(),
      totalHeight.toInt(),
    );

    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }
}
