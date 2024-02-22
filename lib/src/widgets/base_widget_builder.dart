import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:icon_gallery/src/data/data_builder.dart';

class BaseWidgetBuilder<T> extends StatelessWidget {
  const BaseWidgetBuilder({
    super.key,
    required this.items,
    required this.optionBuilders,
  });

  final List<IconValue<T>> items;
  final List<OptionBuilder<T>> optionBuilders;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceAround,
      children: List.generate(
        optionBuilders.length,
        (optionIndex) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            optionBuilders[optionIndex].title,
            Wrap(
              children: List.generate(
                optionBuilders[optionIndex].options.length,
                (index) => optionBuilders[optionIndex].widgetBuilder(
                  context,
                  optionBuilders[optionIndex].options[index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
