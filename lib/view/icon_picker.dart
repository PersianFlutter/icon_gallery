import 'package:flutter/material.dart';
import 'package:icon_gallery/decorators/selected_icon_value.dart';
import 'package:icon_gallery/models/icon_value.dart';
import 'package:icon_gallery/models/item_models/tab_item.dart';

typedef OnIconSelected<T> = void Function(IconValue<T> selectedIcon);

class IconPickerWidget extends StatefulWidget {
  final List<TabItem> tabs;
  final IconValue? selectedIcon;
  final OnIconSelected onIconSelected;

  const IconPickerWidget(
      {super.key,
      required this.tabs,
      this.selectedIcon,
      required this.onIconSelected});

  @override
  State<IconPickerWidget> createState() => _IconPickerWidgetState();
}

class _IconPickerWidgetState<T> extends State<IconPickerWidget> {
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildTabBar() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.tabs.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _onTabTapped(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(widget.tabs[index].title),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTabBar(),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              /* setState(() => _currentPageIndex = index); */
            },
            itemCount: widget.tabs.length,
            itemBuilder: (context, index) {
              final tabItem = widget.tabs[index];
              return ListView.builder(
                itemCount: tabItem.sections.length,
                itemBuilder: (context, sectionIndex) {
                  final section = tabItem.sections[sectionIndex];
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
                              });
                        }).toList(),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
