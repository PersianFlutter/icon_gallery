import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icon_gallery/builders/image_builder.dart';
import 'package:icon_gallery/models/icon_value.dart';

void main() {
  group('ImageAssetOptionBuilder', () {
    testWidgets('should build an Image widget with the provided image asset',
        (WidgetTester tester) async {
      const imagePath = 'assets/images/pf.jpeg'; // Update with your image path
      const width = 100.0;
      const height = 100.0;

      final iconValue = IconValue(imagePath, 'Image Asset');
      final builder =
          ImageOptionBuilder([iconValue], width: width, height: height);

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

    //todo if we want test it here we need to add http and mock here and in pubspec.yaml.
    /* testWidgets('should build an Image widget with the provided image network',
        (WidgetTester tester) async {
      const googleIcon = 'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png'; // Update with your image path
      const width = 100.0;
      const height = 100.0;

       final iconValueNetwork = IconValue(googleIcon, 'Network Image');
      final builderNetwork = ImageOptionBuilder(
        [iconValueNetwork],
        width: width,
        height: height,
        imageType: ImageType.network,
      );
      
      await tester.pumpWidget(MaterialApp(home: Builder(
        builder: (context) {
          return builderNetwork.widgetBuilder(context, iconValueNetwork);
        },
      )));

      final imageFinderNetwork = find.byWidgetPredicate((widget) {
        if (widget is Image && widget.image is NetworkImage) {
          final NetworkImage networkImage = widget.image as NetworkImage;
          return networkImage.url == googleIcon;
        }
        return false;
      });

     expect(imageFinderNetwork, findsOneWidget);
      final Image imageWidgetNetwork = tester.widget<Image>(imageFinderNetwork);
      expect(imageWidgetNetwork.width, width);
      expect(imageWidgetNetwork.height, height);
    }); */
  });
}
