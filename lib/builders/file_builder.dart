import 'dart:io';

import 'package:flutter/material.dart';
import 'package:icon_gallery/builders/option_builder.dart';
import 'package:icon_gallery/models/icon_value.dart';

class FileOptionBuilder extends OptionBuilder<File> {
  const FileOptionBuilder(
    super.options, {
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });
  final double? width;
  final double? height;
  final BoxFit fit;
  @override
  Widget widgetBuilder(BuildContext context, IconValue<File> value) {
    return Image.file(value.value, width: width, height: height, fit: fit);
  }
}