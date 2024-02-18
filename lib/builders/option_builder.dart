import 'package:flutter/material.dart';
import 'package:icon_gallery/models/icon_value.dart';

abstract class OptionBuilder<T> {
  const OptionBuilder(this.options);

  final List<IconValue<T>> options;

  // Builds the widget for a given IconValue<T>
  Widget widgetBuilder(BuildContext context, IconValue<T> value);

  // Filters the list of options based on the given query
  List<IconValue<T>> filterOptions(String filter) {
    return options
        .where((element) =>
            element.name.toLowerCase().contains(filter.toLowerCase()))
        .toList();
  }
}
