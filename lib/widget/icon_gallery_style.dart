import 'package:flutter/material.dart';

class IconGalleryStyle {
  // Size and gaps
  final EdgeInsetsGeometry gridViewPadding;
  final EdgeInsetsGeometry sectionTitlePadding;
  final EdgeInsetsGeometry sectionPadding;

  final double? itemSize;

  // Text Theme
  final TextStyle? sectionTitleStyle;
  final TextStyle? searchBarHintStyle;

  // colors
  final Color? itemColor;

  final BoxFit? fit;

  // gridView styles
  final double gridViewMaxCrossAxisExtent;

  IconGalleryStyle({
    required this.gridViewMaxCrossAxisExtent,
    this.itemSize,
    this.gridViewPadding = EdgeInsets.zero,
    this.sectionPadding = EdgeInsets.zero,
    this.sectionTitlePadding = EdgeInsets.zero,
    this.sectionTitleStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color.fromARGB(143, 0, 0, 0),
    ),
    this.searchBarHintStyle,
    this.itemColor,
    this.fit,
  });
}
