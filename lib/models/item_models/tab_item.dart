import 'package:icon_gallery/models/item_models/section_item.dart';

class TabItem<T> {
  final String title;
  final List<SectionItem<T>> sections;

  TabItem({
    required this.title,
    required this.sections,
  });
}
