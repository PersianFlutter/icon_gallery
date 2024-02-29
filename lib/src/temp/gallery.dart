// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

class IconGalleryTemp<T> extends StatefulWidget {
  IconGalleryTemp({
    super.key,
    required List<IconValue<T>> items,
    this.titleWidget,
    this.searchBar,
    this.searchBarController,
    this.searchBarBorderRadius = 12,
    this.maxCrossAxisExtent = 200,
    this.gridPadding = EdgeInsets.zero,
    this.baseWidgetPadding = EdgeInsets.zero,
    this.itemColor = Colors.black,
    this.itemSize = 20,
    this.onChanged,
    this.selectedItem,
    this.onItemSelected,
    this.filterOnChanged,
    GalleryFilterItemBuilder<T>? itemFilterBuilder,
    GalleryItemWidgetBuilder<T>? itemWidgetBuilder,
  }) : _items = items {
    assert(searchBar != null || searchBarController != null,
        'You must pass either a searchBar widget or a searchBarController.');
    itemFilter = itemFilterBuilder ?? defaultFilterItemBuilder;

    // TODO(alireza): check if the <T> is not a common type we should throw an error to tell the user to provide the [widgetBuilder] function
    _widgetBuilder =
        itemWidgetBuilder; // ?? factoryDesignPatter to make the default widget builder;
  }

  final List<IconValue<T>> _items;
  final T? selectedItem;
  final ValueChanged<T>? onItemSelected;

  final ValueChanged<String>? filterOnChanged;

  late final GalleryItemWidgetBuilder<T>? _widgetBuilder;
  late final GalleryFilterItemBuilder<T> itemFilter;

  final Widget? titleWidget;
  final Widget? searchBar;
  final TextEditingController? searchBarController;
  final double searchBarBorderRadius;
  final ValueChanged<String>? onChanged;

  final double maxCrossAxisExtent;
  final EdgeInsets gridPadding;
  final EdgeInsets baseWidgetPadding;

  final double itemSize;
  final Color itemColor;

  static List<IconValue<T>> defaultFilterItemBuilder<T>(
      List<IconValue<T>> items, String filter) {
    return items
        .where(
          (element) => element.name.toLowerCase().contains(
                filter.toLowerCase(),
              ),
        )
        .toList();
  }

  @override
  State<IconGalleryTemp<T>> createState() => _IconGalleryTempState<T>();
}

class _IconGalleryTempState<T> extends State<IconGalleryTemp<T>> {
  GalleryItemWidgetBuilder<T>? _widgetBuilder;
  TextEditingController? _searchBarController;
  List<IconValue<T>>? _filteredItems;

  @override
  void initState() {
    super.initState();

    _widgetBuilder = widget._widgetBuilder ??
        (context, item) => widgetBuilderFactoryExample(context, item,
            color: widget.itemColor, iconSize: widget.itemSize);

    if (widget.searchBarController != null) {
      _searchBarController = widget.searchBarController!;
      _filteredItems = widget._items;

      _searchBarController?.addListener(_filterItems);
    }
  }

  void _filterItems() {
    final filter = _searchBarController?.text.toLowerCase();
    setState(() {
      _filteredItems = widget._items
          .where((item) => item.name.toLowerCase().contains(filter!))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchBarController
      ?..removeListener(_filterItems)
      ..dispose();

    super.dispose();
  }

  List<Widget> _childrenBuilder() {
    List<IconValue<T>> localItems = _filteredItems ?? widget._items;

    return localItems.map((e) => _widgetBuilder!(context, e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.baseWidgetPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.titleWidget ??
              Text(
                'Icons',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
          const SizedBox(height: 20),
          widget.searchBar ??
              TextField(
                controller: widget.searchBarController,
                onChanged: widget.filterOnChanged,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(widget.searchBarBorderRadius),
                    ),
                  ),
                  hintText: 'Type for filter',
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.extent(
              padding: widget.gridPadding,
              maxCrossAxisExtent: widget.maxCrossAxisExtent,
              children: _childrenBuilder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget widgetBuilderFactoryExample(
    BuildContext context,
    IconValue<T> value, {
    Color? color,
    double? iconSize,
    width,
    height,
  }) {
    return switch (value.value.runtimeType) {
      IconData => Icon(
          value.value as IconData,
          color: color,
          size: iconSize,
        ),
      AssetImage => Image(
          image: value.value as AssetImage,
          width: width,
          height: height,
        ),
      MemoryImage => Image(
          image: value.value as MemoryImage,
          width: width,
          height: height,
        ),
      FileImage => Image(
          image: value.value as FileImage,
          width: width,
          height: height,
        ),
      NetworkImage => Image(
          image: value.value as NetworkImage,
          width: width,
          height: height,
        ),
      SvgAssetLoader => SvgPicture(
          value.value as SvgAssetLoader,
          width: width,
          height: height,
        ),
      SvgStringLoader => SvgPicture(
          value.value as SvgStringLoader,
          width: width,
          height: height,
        ),
      SvgNetworkLoader => SvgPicture(
          value.value as SvgNetworkLoader,
          width: width,
          height: height,
        ),
      SvgFileLoader => SvgPicture(
          value.value as SvgFileLoader,
          width: width,
          height: height,
        ),
      SvgBytesLoader => SvgPicture(
          value.value as SvgBytesLoader,
          width: width,
          height: height,
        ),
      _ => Container(
          color: color,
          width: width,
          height: height,
        ),
    };
  }
}
