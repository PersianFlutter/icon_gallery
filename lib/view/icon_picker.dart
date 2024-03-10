import 'package:flutter/material.dart';
import 'package:icon_gallery/decorators/selected_icon_value.dart';
import 'package:icon_gallery/models/icon_value.dart';
import 'package:icon_gallery/models/item_models/section_item.dart';

typedef OnIconSelected<T> = void Function(IconValue<T> selectedIcon);

class IconPickerWidget extends StatefulWidget {
  final List<SectionItem> sections;
  final IconValue? selectedIcon;
  final OnIconSelected onIconSelected;

  const IconPickerWidget({
    super.key,
    required this.sections,
    this.selectedIcon,
    required this.onIconSelected,
  });

  @override
  State<IconPickerWidget> createState() => _IconPickerWidgetState();
}

class _IconPickerWidgetState<T> extends State<IconPickerWidget> {
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
                    children: section.icons.map((icon) {
                      final isSelected = widget.selectedIcon == icon;
                      final iconWidget = isSelected
                          ? SelectedIconValue(
                              decoratedIcon: icon,
                            )
                          : icon;

                      return InkWell(
                        child: iconWidget.build(context),
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
