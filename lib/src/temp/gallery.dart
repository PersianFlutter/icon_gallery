// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

typedef SearchFieldBuilder = Widget Function(
  BuildContext context,
  TextEditingController controller,
  FocusNode? focusNode,
);

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
    this.searchBarBuilder,
    this.searchBarController,
    this.maxCrossAxisExtent = 200,
    this.gridPadding = EdgeInsets.zero,
    this.baseWidgetPadding = EdgeInsets.zero,
    this.itemColor = Colors.black,
    this.itemSize = 20,
    this.selectedItem,
    this.onItemSelected,
    this.filterOnChanged,
    GalleryFilterItemBuilder<T>? itemFilterBuilder,
    GalleryItemWidgetBuilder<T>? itemWidgetBuilder,
  }) : _items = items {
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

  final SearchFieldBuilder? searchBarBuilder;
  final TextEditingController? searchBarController;

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
  late TextEditingController _searchBarController;

  GalleryItemWidgetBuilder<T>? _widgetBuilder;
  List<IconValue<T>>? _filteredItems;

  @override
  void initState() {
    super.initState();
    _searchBarController =
        widget.searchBarController ?? TextEditingController();

    _widgetBuilder = widget._widgetBuilder ??
        (context, item) => widgetBuilderFactoryExample(context, item,
            color: widget.itemColor, iconSize: widget.itemSize);

    _filteredItems = widget._items;

    _searchBarController.addListener(_onSearchFieldChanged);
  }

  @override
  void didUpdateWidget(covariant IconGalleryTemp<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    _updateTextEditingController(
      oldWidget.searchBarController,
      widget.searchBarController,
    );
  }

  @override
  void dispose() {
    _dismissController(_searchBarController);

    super.dispose();
  }

  void _dismissController(TextEditingController controller) {
    controller.removeListener(_onSearchFieldChanged);

    /// If the controller is provided by the user we are not responsible for disposing it
    /// otherwise if we created it we should dispose it
    if (widget.searchBarController == null) {
      controller.dispose();
    }
  }

  void _updateTextEditingController(
      TextEditingController? old, TextEditingController? current) {
    if ((old == null && current == null) || old == current) {
      return;
    }
    if (old == null) {
      _searchBarController.removeListener(_onSearchFieldChanged);
      _searchBarController.dispose();
      _searchBarController = current!;
    } else if (current == null) {
      _searchBarController.removeListener(_onSearchFieldChanged);
      _searchBarController = TextEditingController();
    } else {
      _searchBarController.removeListener(_onSearchFieldChanged);
      _searchBarController = current;
    }
    _searchBarController.addListener(_onSearchFieldChanged);
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
          widget.searchBarBuilder?.call(
                context,
                _searchBarController,
                null,
              ) ??
              TextField(
                controller: _searchBarController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  hintText: 'Type for filter',
                  prefixIcon: Icon(Icons.search),
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

  void _onSearchFieldChanged() {
    final filter = _searchBarController.text.toLowerCase();
    setState(() {
      _filteredItems = widget._items
          .where((item) => item.name.toLowerCase().contains(filter))
          .toList();
    });
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
