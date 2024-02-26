// ignore_for_file: unused_field

import 'package:flutter/material.dart';

typedef GalleryFilterItemBuilder<T> = List<IconValue<T>> Function(
  List<IconValue<T>> items,
  String filter,
);

typedef GalleryItemWidgetBuilder<T> = Widget Function(
  BuildContext context,
  IconValue<T> value,
);

// TODO(alireza): seperate the data classes to a new file
class IconValue<T> {
  final T value;
  final String name;

  IconValue({
    required this.value,
    required this.name,
  });
}

class IconGalleryTemp<T> extends StatelessWidget {
  IconGalleryTemp({
    super.key,
    required List<IconValue<T>> items,
    this.selectedItem,
    this.onItemSelected,
    GalleryFilterItemBuilder<T>? itemFilterBuilder,
    GalleryItemWidgetBuilder<T>? itemWidgetBuilder,
  }) : _items = items {
    itemFilter = itemFilterBuilder ?? defaultFilterItemBuilder;

    // TODO(alireza): check if the <T> is not a common type we should throw an error to tell the user to provide the [widgetBuilder] function
    _widgetBuilder = itemWidgetBuilder ??
        widgetBuilderFactoryExample; // ?? factoryDesignPatter to make the default widget builder;
  }

  final List<IconValue<T>> _items;
  final T? selectedItem;
  final ValueChanged<T>? onItemSelected;
  late final GalleryItemWidgetBuilder<T>? _widgetBuilder;
  late final GalleryFilterItemBuilder<T> itemFilter;

  // TODO(mahmoud): add other styling options like Color, Size, etc.

  static List<IconValue<T>> defaultFilterItemBuilder<T>(
      List<IconValue<T>> items, String filter) {
    return items
        .where((element) =>
            element.name.toLowerCase().contains(filter.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO(mahmoud): implement the gallery widget
    throw UnimplementedError();
  }
}

Widget widgetBuilderFactoryExample<T>(
    BuildContext context, IconValue<T> value) {
  return switch (T.runtimeType) {
    IconData => Icon(value.value as IconData),
    AssetBundleImageProvider =>
      Image(image: value.value as AssetBundleImageProvider),
    _ => Container(),
  };
}
