import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class IconItem<T> with EquatableMixin {
  const IconItem({
    required this.value,
    required this.name,
  });

  final T value;

  final String name;

  Widget build(
    BuildContext context, {
    double? size = 24,
    Color? color,
    BoxFit? fit,
  });

  @override
  List<Object?> get props => [value, name];
}
