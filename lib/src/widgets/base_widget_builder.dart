import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:icon_gallery/src/data/data_builder.dart';

class BaseWidgetBuilder<T> extends StatelessWidget {
  const BaseWidgetBuilder({
    super.key,
    required this.optionBuilder,
  });

  final OptionBuilder<T> optionBuilder;


  @override
  Widget build(BuildContext context) {
    // TODO(md): Use the optionBuilder to build the widget.
    return Container();
  }
}
