import 'dart:io';
import 'package:string_validator/string_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'TypeImage.dart';

class BaseWidget extends StatelessWidget {
  final TypeImage typeImage;

  final dynamic Value;

  const BaseWidget({super.key, required this.typeImage, this.Value});

  @override
  Widget build(BuildContext context) {
    return (typeImage == TypeImage.svg)
        ? BaseWidgetSvg(Value)
        : (typeImage == TypeImage.iconData)
            ? Icon(Value)
            : BaseWidgetImage(Value);
  }
}

Widget BaseWidgetImage(dynamic Value) {
  if (Value is String) {
    if (isURL(Value)) {
      return Image.network(Value);
    }
    return Image.asset(Value);
  } else if (Value is File) {
    return Image.file(Value);
  } else if (Value is Uint8List) {
    return Image.memory(Value);
  }
  return SizedBox(width: 0, height: 0);
}

Widget BaseWidgetSvg(dynamic Value) {
  if (Value is String) {
    if (isURL(Value)) {
      return SvgPicture.network(Value);
    }
    return SvgPicture.asset(Value);
  } else if (Value is File) {
    return SvgPicture.file(Value);
  } else if (Value is Uint8List) {
    return SvgPicture.memory(Value);
  }
  return SizedBox(width: 0, height: 0);
}
