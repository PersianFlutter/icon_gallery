import 'package:flutter/material.dart';
import 'package:icon_gallery/model/section_item.dart';
import 'package:icon_gallery/model/type/icon_item.dart';
import 'package:icon_gallery/widget/icon_gallery_style.dart';

typedef SearchFieldBuilder = Widget Function(
  BuildContext context,
  TextEditingController controller,
  FocusNode? focusNode,
);

typedef OnIconSelected<T> = void Function(IconItem<T> selectedIcon);

class IconGallery extends StatefulWidget {
  final SearchFieldBuilder? searchBarBuilder;
  final TextEditingController? searchBarController;
  final IconGalleryStyle style;
  final List<SectionItem> sections;
  final IconItem? selectedIcon;
  final OnIconSelected onIconSelected;

  const IconGallery({
    super.key,
    required this.sections,
    required this.onIconSelected,
    required this.style,
    this.selectedIcon,
    this.searchBarBuilder,
    this.searchBarController,
  });

  IconGallery.list({
    Key? key,
    required List<IconItem> icons,
    required OnIconSelected onIconSelected,
    required IconItem? selectedIcon,
    required double gridViewMaxCrossAxisExtent,
    String title = 'Icons',
  }) : this(
          key: key,
          sections: [
            SectionItem(
              title: title,
              items: icons,
            ),
          ],
          style: IconGalleryStyle(
            gridViewMaxCrossAxisExtent: gridViewMaxCrossAxisExtent,
          ),
          selectedIcon: selectedIcon,
          onIconSelected: onIconSelected,
        );

  @override
  State<IconGallery> createState() => _IconGalleryState();
}

class _IconGalleryState<T> extends State<IconGallery> {
  late TextEditingController _searchBarController;
  late List<SectionItem> filteredItem;

  @override
  void initState() {
    super.initState();

    filteredItem = widget.sections;

    _searchBarController =
        widget.searchBarController ?? TextEditingController();

    _searchBarController.addListener(_onSearchFieldChanged);
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  _disposeController() {
    if (widget.searchBarController == null) {
      _searchBarController.dispose();
    }
  }

  _onSearchFieldChanged() {
    final searchValue = _searchBarController.text.toLowerCase();
    setState(() {
      filteredItem = widget.sections
          .map((section) {
            final filteredItems = section.items
                .where((item) => item.name.toLowerCase().contains(searchValue))
                .toList();
            return section.copyWith(items: filteredItems);
          })
          .where((section) => section.items.isNotEmpty)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchField = widget.searchBarBuilder?.call(
          context,
          _searchBarController,
          null,
        ) ??
        DefaultSearchField(controller: _searchBarController);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        searchField,
        Expanded(
          child: ListView.builder(
            itemCount: filteredItem.length,
            itemBuilder: (context, sectionIndex) {
              final section = filteredItem[sectionIndex];
              return Padding(
                padding: widget.style.sectionPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: widget.style.sectionTitlePadding,
                      child: Text(
                        section.title,
                        style: widget.style.sectionTitleStyle ??
                            TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(.5),
                            ),
                      ),
                    ),
                    GridView.extent(
                      shrinkWrap: true,
                      padding: widget.style.gridViewPadding,
                      maxCrossAxisExtent:
                          widget.style.gridViewMaxCrossAxisExtent,
                      children: _itemBuilder(
                        filteredItem[sectionIndex].items,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  List<Widget> _itemBuilder(List<IconItem> items) {
    return items
        .map(
          (e) => InkWell(
            onTap: () {
              widget.onIconSelected(e);
            },
            child: e.build(
              context,
              color: widget.style.itemColor,
              fit: widget.style.fit,
              size: widget.style.itemSize,
            ),
          ),
        )
        .toList();
  }
}

class IconHolder extends StatelessWidget {
  const IconHolder({
    super.key,
    this.isSelected = false,
    this.selectedColor = Colors.blue,
    this.selectedBackgroundColor = Colors.transparent,
    required this.icon,
  });
  final bool isSelected;
  final Color selectedColor;
  final Color selectedBackgroundColor;
  final IconItem icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: selectedBackgroundColor, shape: BoxShape.circle),
      child: icon.build(
        context,
        size: 24,
        color: selectedColor,
        fit: BoxFit.contain,
      ),
    );
  }
}

class DefaultSearchField extends StatelessWidget {
  const DefaultSearchField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        hintText: 'Type for filter',
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}
