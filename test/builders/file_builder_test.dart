import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icon_gallery/builders/file_builder.dart';
import 'package:icon_gallery/models/icon_value.dart';

void main() {
  group('FileOptionBuilder', () {
    testWidgets('should build an Image widget with the provided file',
        (WidgetTester tester) async {
      const imagePath = 'assets/images/pf.jpeg'; // Update with your image path
      final file = File(imagePath);
      const width = 100.0;
      const height = 100.0;

      final iconValue = IconValue(file, 'Test Image');
      final builder =
          FileOptionBuilder([iconValue], width: width, height: height);

      await tester.pumpWidget(MaterialApp(home: Builder(
        builder: (context) {
          return builder.widgetBuilder(context, iconValue);
        },
      )));

      final imageFinder = find.byWidgetPredicate((widget) {
        if (widget is Image && widget.image is FileImage) {
          final FileImage fileImage = widget.image as FileImage;
          return fileImage.file.path == imagePath;
        }
        return false;
      });

      expect(imageFinder, findsOneWidget);
      final Image imageWidget = tester.widget<Image>(imageFinder);
      expect(imageWidget.width, width);
      expect(imageWidget.height, height);
    });
  });
}
