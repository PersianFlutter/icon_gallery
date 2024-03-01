import 'package:flutter/material.dart';
import 'package:icon_gallery/models/icon_value.dart';

class IconDataIconValue extends IconValue<IconData> {
  final String _name;
  final IconData _iconData;

  IconDataIconValue({required String name, required IconData iconData})
      : _name = name,
        _iconData = iconData;

  @override
  String get name => _name;

  @override
  IconData get value => _iconData;

  @override
  Widget build(BuildContext context,
      {Color? color, BoxFit? fit, double? size = 24}) {
    return Icon(
      value,
      color: color ?? Colors.red,
      size: size,
    );
  }
}
