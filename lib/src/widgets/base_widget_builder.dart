import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:icon_gallery/src/data/data_builder.dart';

class BaseWidgetBuilder<T> extends StatelessWidget {
  const BaseWidgetBuilder({
    super.key,
    required this.items,
    required this.optionBuilder,
  });

  final List<IconValue<T>> items;
  final OptionBuilder<T> optionBuilder;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth < 600 ? 2 : 4;
    double itemWidth = (screenWidth / crossAxisCount) - 16;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: itemWidth,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => optionBuilder.widgetBuilder(
        context,
        items[index],
      ),
    );
  }
}
