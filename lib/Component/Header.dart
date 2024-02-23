import 'package:flutter/material.dart';
import '../GalleryValue.dart';
import '../GalleryController.dart';

class Header extends StatelessWidget {
  final List<String> header;

  final GalleryController galleryController;

  const Header(
      {super.key, required this.header, required this.galleryController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Center(
        child: ValueListenableBuilder<GalleryValue>(
            valueListenable: galleryController,
            builder: (context, value, _) {
              return ListView.builder(
                  itemCount: header.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    bool isActive =
                        header.elementAt(index) == value.SelectedHeader;
                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          galleryController.ChangeHeader(
                              header.elementAt(index));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: isActive
                                ? Colors.lightBlueAccent
                                : Colors.grey.withAlpha(300),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          margin: EdgeInsets.only(right: 10),
                          child: Text(
                            '# ${header.elementAt(index)}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
