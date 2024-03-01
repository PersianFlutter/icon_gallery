import 'package:flutter/material.dart';
import 'package:icon_gallery/models/icon_value.dart';

class SelectedIconValue<T> extends IconValue<T> {
  final Color selectedColor;
  final Color selectedBackgroundColor;
  final IconValue<T> decoratedIcon;
  SelectedIconValue({
    required this.decoratedIcon,
    this.selectedColor = Colors.blue,
    this.selectedBackgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context,
      {double size = 24, Color? color, BoxFit? fit}) {
    return Container(
      decoration:
          BoxDecoration(color: selectedBackgroundColor, shape: BoxShape.circle),
      child: decoratedIcon.build(context,
          size: size, color: selectedColor, fit: fit),
    );
  }

  @override
  T get value => decoratedIcon.value;

  @override
  String get name => decoratedIcon.name;
}
