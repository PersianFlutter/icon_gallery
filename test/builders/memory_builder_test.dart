import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icon_gallery/builders/memory_builder.dart';
import 'package:icon_gallery/models/icon_value.dart';

void main() {
  group('MemoryOptionBuilder', () {
    testWidgets('should build an Image widget with the provided image data',
        (WidgetTester tester) async {
      // Create test image data (e.g., 1x1 transparent pixel)
    final testImageData =   Uint8List.fromList(<int>[
        137,
        80,
        78,
        71,
        13,
        10,
        26,
        10,
        0,
        0,
        0,
        13,
        73,
        72,
        68,
        82,
        0,
        0,
        0,
        10,
        0,
        0,
        0,
        10,
        8,
        0,
        0,
        0,
        0,
        168,
        89,
        144,
        97,
        0,
        0,
        0,
        15,
        73,
        68,
        65,
        84,
        120,
        156,
        99,
        248,
        207,
        128,
        0,
        52,
        103,
        3,
        0,
        36,
        102,
        9,
        247,
        69,
        240,
        144,
        162,
        0,
        0,
        0,
        0,
        73,
        69,
        78,
        68,
        174,
        66,
        96,
        130,
      ]);

      // Set up the test parameters
      const double width = 100.0;
      const double height = 100.0;
      const BoxFit fit = BoxFit.contain;

      // Create an IconValue instance with test image data
      final iconValue = IconValue(testImageData, 'Image Memory');

      // Create a MemoryOptionBuilder instance
      final builder = MemoryOptionBuilder([iconValue],
          width: width, height: height, fit: fit);

      // Pump the widget tree
      await tester.pumpWidget(MaterialApp(home: Builder(
        builder: (context) {
          return builder.widgetBuilder(context, iconValue);
        },
      )));

      // Find the Image widget
      final imageFinder = find.byWidgetPredicate((widget) {
        if (widget is Image && widget.image is MemoryImage) {
          final MemoryImage memoryImage = widget.image as MemoryImage;
          return memoryImage.bytes == testImageData;
        }
        return false;
      });

      // Verify that the Image widget is found
      expect(imageFinder, findsOneWidget);

      // Verify that the Image widget has the correct width, height, and fit
      final Image imageWidget = tester.widget<Image>(imageFinder);
      expect(imageWidget.width, width);
      expect(imageWidget.height, height);
      expect(imageWidget.fit, fit);
    });
  });
}
