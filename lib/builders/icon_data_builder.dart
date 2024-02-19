import 'package:flutter/material.dart';
import 'package:icon_gallery/builders/option_builder.dart';
import 'package:icon_gallery/models/icon_value.dart';

class IconDataOptionBuilder extends OptionBuilder<IconData> {
  const IconDataOptionBuilder(
    super.options, {
    this.size = 24.0,
    this.color = Colors.black,
  });

  final double? size;
  final Color? color;

  @override
  Widget widgetBuilder(BuildContext context, IconValue<IconData> value) {
    return Icon(value.value, size: size, color: color);
  }
}
