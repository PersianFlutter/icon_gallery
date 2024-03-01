import 'package:icon_gallery/models/icon_value.dart';

class SectionItem<T> {
  final String title;
  final List<IconValue<T>> icons;

  SectionItem({
    required this.title,
    required this.icons,
  });
}
