import 'package:flutter/material.dart';
import 'BaseWidget.dart';
import 'TypeImage.dart';
import '../GalleryController.dart';
import '../GalleryValue.dart';

class Body extends StatelessWidget {
  final GalleryController galleryController;

  final Map<String, List> Data;

  const Body({super.key, required this.galleryController, required this.Data});

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: ValueListenableBuilder<GalleryValue>(
            valueListenable: galleryController,
            builder: (context, value, _) {
              String header = '';
              String ActiveImg = '';
              List? lst;

              if (value.SelectedHeader != '') {
                header = value.SelectedHeader;
                ActiveImg = value.SelectedImg.toString();
                lst = Data[header]!;
              }

              return lst != null
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10),
                      itemCount: lst.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        bool Active =
                            ActiveImg == lst!.elementAt(index).toString();
                        return GestureDetector(
                          onTap: () {
                            galleryController.ChangeImg(lst!.elementAt(index));
                          },
                          child: Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                    color: Active
                                        ? Colors.lightBlueAccent
                                        : Colors.transparent,
                                    width: Active ? 5 : 0)),
                            child: Builder(builder: (context) {
                              TypeImage typeImage = TypeImage.values
                                      .where(
                                          (element) => element.name == header)
                                      .firstOrNull ??
                                  TypeImage.any;
                              return FittedBox(
                                  child: BaseWidget(
                                      typeImage: typeImage,
                                      Value: lst!.elementAt(index)));
                            }),
                          ),
                        );
                      })
                  : SizedBox(width: 0, height: 0);
            }));
  }
}
