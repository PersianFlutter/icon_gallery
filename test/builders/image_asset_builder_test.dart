import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icon_gallery/builders/image_asset_builder.dart';
import 'package:icon_gallery/models/icon_value.dart';

void main() {
  group('ImageAssetOptionBuilder', () {
    testWidgets('should build an Image widget with the provided image asset',
        (WidgetTester tester) async {
      const imagePath =
          'assets/images/pf.jpeg'; // Update with your image path
      const width = 100.0;
      const height = 100.0;

      final iconValue = IconValue(imagePath, 'Image Asset');
      final builder =
          ImageAssetOptionBuilder([iconValue], width: width, height: height);

      await tester.pumpWidget(MaterialApp(home: Builder(
        builder: (context) {
          return builder.widgetBuilder(context, iconValue);
        },
      )));

      final imageFinder = find.byWidgetPredicate((widget) {
        if (widget is Image && widget.image is AssetImage) {
          final AssetImage assetImage = widget.image as AssetImage;
          return assetImage.assetName == imagePath;
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
