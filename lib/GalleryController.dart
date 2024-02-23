import 'package:flutter/material.dart';

import 'GalleryValue.dart';

class GalleryController extends ValueNotifier<GalleryValue> {
  GalleryController(super.value);

  ChangeHeader(String Input) {
    value.SelectedHeader = Input;
    value.SelectedImg = '';
    notifyListeners();
  }

  ChangeImg(dynamic Input) {
    value.SelectedImg = Input;
    notifyListeners();
  }
}
