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
    this.crossAxisCount = 10,
    this.crossAxisSpacing = 0,
    this.mainAxisSpacing = 0,
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

  /// `crossAxisCount`: Number of items displayed across the grid.
  /// For vertical grids, it's columns; for horizontal, rows.
  final int crossAxisCount;

  /// `crossAxisSpacing`: Horizontal space between items in a vertical grid,
  /// and vertical space in a horizontal grid.
  final double crossAxisSpacing;

  /// `mainAxisSpacing`: Space between items along the grid's scrolling direction.
  final double mainAxisSpacing;

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
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
      ),
      itemCount: _items.length,
      itemBuilder: (context, index) => _widgetBuilder!(
        context,
        _items[index],
      ),
    );
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
