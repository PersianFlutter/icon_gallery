library icon_gallery;

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:icon_gallery/builders/file_builder.dart';
import 'package:icon_gallery/builders/icon_data_builder.dart';
import 'package:icon_gallery/builders/image_builder.dart';
import 'package:icon_gallery/builders/memory_builder.dart';
import 'package:icon_gallery/builders/option_builder.dart';
import 'package:icon_gallery/builders/svg_builder.dart';
import 'package:icon_gallery/models/icon_value.dart';

class ImageGallery extends StatelessWidget {
  final List<IconValue<dynamic>> items;
  final OptionBuilder<dynamic> builder;

  const ImageGallery._({Key? key, required this.items, required this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
      ),
      itemCount: items.length,
      shrinkWrap: true,
      itemBuilder: (context, index) =>
          builder.widgetBuilder(context, items[index]),
    );
  }

  static ImageGallery svg(List<IconValue<String>> items,
      {double? width,
      double? height,
      BoxFit fit = BoxFit.contain,
      ImageType imageType = ImageType.asset}) {
    return ImageGallery._(
      items: items,
      builder: SvgOptionBuilder(items,
          width: width, height: height, fit: fit, imageType: imageType),
    );
  }

  static ImageGallery image(List<IconValue<String>> items,
      {double? width,
      double? height,
      BoxFit fit = BoxFit.contain,
      ImageType imageType = ImageType.asset}) {
    return ImageGallery._(
      items: items,
      builder: ImageOptionBuilder(items,
          width: width, height: height, fit: fit, imageType: imageType),
    );
  }

  static ImageGallery file(List<IconValue<File>> items,
      {double? width, double? height, BoxFit fit = BoxFit.contain}) {
    return ImageGallery._(
      items: items,
      builder: FileOptionBuilder(items, width: width, height: height, fit: fit),
    );
  }

  static ImageGallery memory(List<IconValue<Uint8List>> items,
      {double? width, double? height, BoxFit fit = BoxFit.contain}) {
    return ImageGallery._(
      items: items,
      builder:
          MemoryOptionBuilder(items, width: width, height: height, fit: fit),
    );
  }

  static ImageGallery iconData(List<IconValue<IconData>> items,
      {double? size, Color? color, BoxFit fit = BoxFit.contain}) {
    return ImageGallery._(
      items: items,
      builder: IconDataOptionBuilder(
        items,
        size: size,
        color: color,
      ),
    );
  }

  static ImageGallery custom(
      List<IconValue<dynamic>> items, OptionBuilder<dynamic> builder) {
    return ImageGallery._(items: items, builder: builder);
  }

  // Methods to display in a dialog or bottom sheet
  void showAsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(child: this),
    );
  }

  void showAsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => this,
    );
  }
}
