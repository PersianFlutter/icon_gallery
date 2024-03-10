import 'package:flutter/material.dart';
import 'package:icon_gallery/model/type/icon_item.dart';
import 'package:icon_gallery/model/section_item.dart';

typedef OnIconSelected<T> = void Function(IconItem<T> selectedIcon);

class IconGallery extends StatefulWidget {
  final List<SectionItem> sections;
  final IconItem? selectedIcon;
  final OnIconSelected onIconSelected;

  const IconGallery({
    super.key,
    required this.sections,
    this.selectedIcon,
    required this.onIconSelected,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(section.title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  Wrap(
                    children: section.items.map((icon) {
                      final isSelected = widget.selectedIcon == icon;

                      return InkWell(
                        child: IconHolder(
                          isSelected: isSelected,
                          icon: icon,
                        ),
                        onTap: () {
                          widget.onIconSelected(icon);
                        },
                      );
                    }).toList(),
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
