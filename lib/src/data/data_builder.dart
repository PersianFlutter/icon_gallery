import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class IconValue<T> {
  final T value;
  final String name;

  IconValue({
    required this.value,
    required this.name,
  });
}

abstract class OptionBuilder<T> {
  const OptionBuilder(this.options);

  final List<IconValue<T>> options;

  String nameBuilder(IconValue<T> value) => value.name;

  List<IconValue<T>> filterOptions(String filter) {
    return options
        .where((element) =>
            element.name.toLowerCase().contains(filter.toLowerCase()))
        .toList();
  }

  Widget widgetBuilder(BuildContext context, IconValue<T> value);
}

class IconDataOptionBuilder extends OptionBuilder<IconData> {
  const IconDataOptionBuilder(
    super.options, {
    this.size,
    this.color,
  });

  final double? size;
  final Color? color;

  @override
  Widget widgetBuilder(BuildContext context, IconValue<IconData> value) {
    return Icon(
      value.value,
      size: size,
      color: color,
    );
  }
}

class ImageAssetOptionBuilder extends OptionBuilder<String> {
  const ImageAssetOptionBuilder(
    super.options,
    this.width,
    this.height,
    this.fit,
  );

  final double? width;
  final double? height;

  final BoxFit? fit;

  @override
  Widget widgetBuilder(BuildContext context, IconValue<String> value) {
    return Image.asset(
      value.value,
      width: width,
      height: height,
      fit: fit,
    );
  }
}

class ImageNetworkOptionBuilder extends OptionBuilder<String> {
  const ImageNetworkOptionBuilder(
    super.options, {
    this.width,
    this.height,
    this.fit,
  });
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget widgetBuilder(BuildContext context, IconValue<String> value) {
    return Image.network(
      value.value,
      width: width,
      height: height,
      fit: fit,
    );
  }
}

class SvgOptionBuilder extends OptionBuilder<String> {
  final double? width;
  final double? height;
  final Color? color;
  final BlendMode? blendMode;

  SvgOptionBuilder(
    super.options, {
    this.width,
    this.height,
    this.color,
    this.blendMode,
  });

  @override
  Widget widgetBuilder(BuildContext context, IconValue<String> value) {
    return SvgPicture.asset(
      value.value,
      width: width,
      height: height,
      colorFilter: color == null
          ? null
          : ColorFilter.mode(
              color!,
              blendMode ?? BlendMode.srcIn,
            ),
    );
  }
}
