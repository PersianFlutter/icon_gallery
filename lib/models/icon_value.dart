import 'package:flutter/material.dart';

abstract class IconValue<T> {
  T get value;
  String get name;
  Widget build(
    BuildContext context, {
    double size = 24,
    Color? color,
    BoxFit? fit,
  });
}
