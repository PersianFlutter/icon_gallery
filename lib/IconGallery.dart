import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Component/Body.dart';
import 'Component/Header.dart';
import 'GalleryController.dart';
import 'GalleryValue.dart';
import 'Component/BaseWidget.dart';
import 'Component/TypeImage.dart';
import 'TypeImageImport.dart';

class IconGallery extends StatefulWidget {
  final Map<TypeImageImport, List> Data;

  final GalleryController galleryController;

  const IconGallery(
      {super.key, required this.Data, required this.galleryController});

  @override
  State<IconGallery> createState() => _IconGalleryState();
}

class _IconGalleryState extends State<IconGallery> {
  List<String> extensiones = [];

  Map<String, List> lst = Map();

  late WidgetsBinding _widgetsBinding;

  @override
  void initState() {
    _widgetsBinding = WidgetsBinding.instance;

    for (MapEntry<TypeImageImport, List> d in widget.Data.entries) {
      extensiones.add(d.key.name);
      lst[d.key.name] = d.value;
    }

    super.initState();

    _widgetsBinding.addPostFrameCallback((timeStamp) {
      if (widget.galleryController.value.SelectedHeader == '') {
        widget.galleryController.ChangeHeader(extensiones.first);
      }
      print(extensiones.toString());
      print(lst.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.8.sw,
      constraints: BoxConstraints(maxHeight: 0.7.sh),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Header(
              header: extensiones.toList(),
              galleryController: widget.galleryController),
          SizedBox(height: 10),
          Body(galleryController: widget.galleryController, Data: lst),
          ValueListenableBuilder<GalleryValue>(
              valueListenable: widget.galleryController,
              builder: (context, value, _) {
                bool Active = value.SelectedImg != '';
                return ElevatedButton(
                  onPressed: Active
                      ? () {
                          String header = value.SelectedHeader;
                          dynamic Img = value.SelectedImg;

                          TypeImage typeImage = TypeImage.values
                                  .where((element) => element.name == header)
                                  .firstOrNull ??
                              TypeImage.any;

                          Widget _widget =
                              BaseWidget(typeImage: typeImage, Value: Img);

                          Navigator.pop(context, _widget);
                        }
                      : null,
                  child: Text('تایید', style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                      fixedSize:
                          MaterialStateProperty.all(Size(double.infinity, 45)),
                      backgroundColor: MaterialStateProperty.all(Active
                          ? Colors.lightBlueAccent
                          : Colors.grey.shade300),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                );
              }),
        ],
      ),
    );
  }
}
