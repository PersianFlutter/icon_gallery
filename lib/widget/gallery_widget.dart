import 'package:flutter/material.dart';
import 'package:icon_gallery/model/section_item.dart';
import 'package:icon_gallery/model/type/icon_item.dart';

typedef OnIconSelected<T> = void Function(IconItem<T> selectedIcon);

class IconGallery extends StatefulWidget {
  final List<SectionItem> sections;
  final IconItem? selectedIcon;
  final OnIconSelected onIconSelected;
  final double maxCrossAxisExtent;

  const IconGallery({
    super.key,
    required this.sections,
    required this.onIconSelected,
    this.selectedIcon,
    this.maxCrossAxisExtent = 30,
  });

  IconGallery.list({
    Key? key,
    String title = 'Icons',
    required List<IconItem> icons,
    IconItem? selectedIcon,
    required OnIconSelected onIconSelected,
  }) : this(
          key: key,
          sections: [
            SectionItem(
              title: title,
              items: icons,
            ),
          ],
          selectedIcon: selectedIcon,
          onIconSelected: onIconSelected,
        );

  @override
  State<IconGallery> createState() => _IconGalleryState();
}

class _IconGalleryState<T> extends State<IconGallery> {
  List<Widget> _itemBuilder(List<IconItem> items) {
    return items
        .map(
          (e) => InkWell(
            onTap: () {
              widget.onIconSelected(e);
            },
            child: e.build(context),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.sections.length,
            itemBuilder: (context, sectionIndex) {
              final section = widget.sections[sectionIndex];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section.title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  GridView.extent(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    maxCrossAxisExtent: widget.maxCrossAxisExtent,
                    children: _itemBuilder(
                      widget.sections[sectionIndex].items,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
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
