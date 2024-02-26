// Create a dialog to show the Icon gallery widget

import 'package:flutter/material.dart';
import 'package:icon_gallery/src/temp/gallery.dart';

Future<IconValue<T>?> showIconGalleryDialog<T>({
  required BuildContext context,
  required List<IconValue<T>> items,
  T? selectedItem,
  ValueChanged<T>? onItemSelected,
  GalleryFilterItemBuilder<T>? itemFilterBuilder,
  GalleryItemWidgetBuilder<T>? itemWidgetBuilder,
  // TODO(mahmoud): add other styling options like Color, Size, etc.
}) {
  return showDialog<IconValue<T>>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Select an Icon'),
        content: IconGalleryTemp<T>(
          items: items,
          selectedItem: selectedItem,
          // TODO(mahmoud): I'm not sure that we have to pop the navigator here or not
          // but if we have to we should do it this way:
          //
          // onItemSelected:  (value) {
          //   onItemSelected?.call(value);
          //   Navigator.of(context).pop(value);
          // },

          onItemSelected:
              onItemSelected ?? (value) => Navigator.of(context).pop(value),
          itemFilterBuilder: itemFilterBuilder,
          itemWidgetBuilder: itemWidgetBuilder,
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK OR SOMETHING'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
