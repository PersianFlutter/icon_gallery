import 'package:flutter/material.dart';
import 'package:icon_gallery/models/type/icon_item.dart';

class IconDataItem extends IconItem<IconData> {
  const IconDataItem({required super.name, required super.value});

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
