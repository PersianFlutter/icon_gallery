import 'package:flutter/widgets.dart';
import 'package:icon_gallery/icon_gallery.dart';

class BaseWidgetBuilder extends StatelessWidget {
  const BaseWidgetBuilder({
    required this.type,
    super.key,
  });

  final BaseWidgetType type;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
