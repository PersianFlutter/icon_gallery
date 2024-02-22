import 'package:flutter/material.dart';
import 'package:icon_gallery/src/data/data_builder.dart';

class BaseWidgetBuilder<T> extends StatelessWidget {
  const BaseWidgetBuilder({
    super.key,
    required this.items,
    required this.optionBuilders,
    this.onSelected,
  });

  final List<IconValue<T>> items;
  final List<OptionBuilder<T>> optionBuilders;
  final ValueChanged<IconValue<T>>? onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: optionBuilders
          .map((builder) => _buildOptionColumn(context, builder))
          .toList(),
    );
  }

  Widget _buildOptionColumn(BuildContext context, OptionBuilder<T> builder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (builder.title != null) builder.title!,
        Wrap(
          alignment: WrapAlignment.start,
          children: builder.options
              .map((option) => _buildOption(context, builder, option))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildOption(
      BuildContext context, OptionBuilder<T> builder, IconValue<T> option) {
    return InkWell(
      onTap: () => onSelected?.call(option),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
        child: builder.widgetBuilder(context, option),
      ),
    );
  }
}
