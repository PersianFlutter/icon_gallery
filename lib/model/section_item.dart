import 'package:equatable/equatable.dart';
import 'package:icon_gallery/model/type/icon_item.dart';

class SectionItem extends Equatable {
  const SectionItem({
    required this.title,
    required this.items,
  });

  final String title;
  final List<IconItem> items;

  SectionItem copyWith({
    String? title,
    List<IconItem>? items,
  }) {
    return SectionItem(
      title: title ?? this.title,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [title, items];
}
