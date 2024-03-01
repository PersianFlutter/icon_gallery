import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icon_gallery/models/icon_value.dart';

class SvgIconValue extends IconValue<String> {
  final String _name;
  final String _svgPath;

  SvgIconValue({required String name, required String svgPath})
      : _name = name,
        _svgPath = svgPath;

  @override
  String get name => _name;

  @override
  String get value => _svgPath;

  @override
  Widget build(BuildContext context,
      {Color? color, BoxFit? fit, double? size = 24}) {
    return SvgPicture.asset(
      value,
      fit: fit ?? BoxFit.none,
      colorFilter: ColorFilter.mode(color ?? Colors.white, BlendMode.srcIn),
      width: size,
      height: size,
    );
  }
}
