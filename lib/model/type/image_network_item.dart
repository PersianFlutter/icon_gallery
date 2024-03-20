import 'package:flutter/material.dart';
import 'package:icon_gallery/model/type/icon_item.dart';

class ImageNetworkItem extends IconItem<String> {
  ImageNetworkItem({
    required String url,
    required super.name,
  }) : super(
          value: url,
        );

  @override
  Widget build(
    BuildContext context, {
    /// The size of the rendered image. Defaults to 24.
    double size = 24,
    Color? color,

    /// The fit mode for the image. Defaults to BoxFit.none.
    BoxFit? fit,
  }) {
    return Image.network(
      value,
      fit: fit ?? BoxFit.none,
      width: size,
      height: size,
    );
  }
}
