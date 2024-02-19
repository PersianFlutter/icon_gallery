import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:icon_gallery/builders/option_builder.dart';
import 'package:icon_gallery/models/icon_value.dart';

class MemoryOptionBuilder extends OptionBuilder<Uint8List> {
  const MemoryOptionBuilder(
    super.options, {
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });
  final double? width;
  final double? height;
  final BoxFit fit;
  @override
  Widget widgetBuilder(BuildContext context, IconValue<Uint8List> value) {
    return Image.memory(value.value, width: width, height: height, fit: fit);
  }
}
