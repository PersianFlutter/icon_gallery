import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icon_gallery/model/type/icon_item.dart';

class SvgItem extends IconItem<String> {
 const SvgItem({required super.name, required String svgPath})
      : super(value: svgPath);

  @override
  Widget build(
    BuildContext context, {
    Color? color,
    BoxFit? fit,
    double? size = 24,
  }) {
    return SvgPicture.asset(
      value,
      fit: fit ?? BoxFit.none,
      colorFilter: ColorFilter.mode(color ?? Colors.red, BlendMode.srcIn),
      width: size,
      height: size,
    );
  }
}
