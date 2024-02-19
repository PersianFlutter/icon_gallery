import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icon_gallery/builders/svg_builder.dart';
import 'package:icon_gallery/models/icon_value.dart';

void main() {
  group('SvgOptionBuilder', () {
    testWidgets('should build an SvgPicture widget with the provided asset',
        (WidgetTester tester) async {
      const svgPath =
          'assets/images/wishlist_active.svg'; // Update with your SVG path
      const width = 100.0;
      const height = 100.0;

      final iconValue = IconValue(svgPath, 'Test SVG');
      final builder =
          SvgOptionBuilder([iconValue], width: width, height: height);

      await tester.pumpWidget(MaterialApp(home: Builder(
        builder: (context) {
          return builder.widgetBuilder(context, iconValue);
        },
      )));
      final svgFinder = find.byWidgetPredicate((widget) {
        if (widget is SvgPicture) {
          return widget.bytesLoader.toString().contains(svgPath);
        }
        return false;
      });

      expect(svgFinder, findsOneWidget);
      final SvgPicture svgWidget = tester.widget<SvgPicture>(svgFinder);
      expect(svgWidget.width, width);
      expect(svgWidget.height, height);
    });

    /* testWidgets(
        'should build an SvgPicture widget with the provided network URL',
        (WidgetTester tester) async {
      const svgUrl = 'https://example.com/icon.svg'; // Update with your SVG URL
      const width = 100.0;
      const height = 100.0;

      final iconValue = IconValue(svgUrl, 'Test SVG');
      final builder = SvgOptionBuilder([iconValue],
          width: width, height: height, imageType: ImageType.network);

      await tester.pumpWidget(MaterialApp(home: Builder(
        builder: (context) {
          return builder.widgetBuilder(context, iconValue);
        },
      )));

      final svgFinder = find.byWidgetPredicate((widget) {
        if (widget is SvgPicture && widget.pictureProvider is NetworkPicture) {
          final NetworkPicture networkPicture =
              widget.pictureProvider as NetworkPicture;
          return networkPicture.url == svgUrl;
        }
        return false;
      });

      expect(svgFinder, findsOneWidget);
      final SvgPicture svgWidget = tester.widget<SvgPicture>(svgFinder);
      expect(svgWidget.width, width);
      expect(svgWidget.height, height);
    }); */
  });
}
