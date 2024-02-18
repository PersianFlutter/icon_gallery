import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icon_gallery/builders/icon_data_builder.dart';
import 'package:icon_gallery/models/icon_value.dart';

void main() {
  group('IconDataOptionBuilder', () {
    testWidgets('should build an Icon widget with the provided value',
        (WidgetTester tester) async {
      const iconData = Icons.favorite;
      const size = 24.0;
      const color = Colors.red;

      final iconValue = IconValue(iconData, 'Favorite Icon');
      final builder =
          IconDataOptionBuilder([iconValue], size: size, color: color);

      await tester.pumpWidget(MaterialApp(home: Builder(
        builder: (context) {
          return builder.widgetBuilder(context, iconValue);
        },
      )));

      final iconFinder = find.byIcon(iconData);

      expect(iconFinder, findsOneWidget);
      expect(tester.widget<Icon>(iconFinder).size, size);
      expect(tester.widget<Icon>(iconFinder).color, color);
    });
  });
}
