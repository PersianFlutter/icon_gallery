import 'package:flutter/material.dart';
import 'package:icon_gallery/builders/option_builder.dart';
import 'package:icon_gallery/models/icon_value.dart';

class ImageOptionBuilder extends OptionBuilder<String> {
  const ImageOptionBuilder(
    super.options, {
    this.width,
    this.height,
    this.imageType = ImageType.asset,
    this.fit = BoxFit.contain,
  });

  final double? width;
  final double? height;
  final BoxFit fit;
  final ImageType imageType ;
  @override
  Widget widgetBuilder(BuildContext context, IconValue<String> value) {
      switch(imageType){
        case ImageType.asset:
          return Image.asset(value.value, width: width, height: height, fit: fit);
        case ImageType.network:
          return Image.network(value.value, width: width, height: height, fit: fit);
      }
  }
}
enum ImageType {
  asset,
  network,
} 
