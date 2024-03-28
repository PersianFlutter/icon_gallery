import 'package:flutter/material.dart';
import 'package:icon_gallery/icon_gallery.dart';
import 'package:icon_gallery/widget/icon_gallery_style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController searchBarController;

  late List<IconDataItem> iconList1;
  late List<IconDataItem> iconList2;
  late List<SvgItem> iconList3;

  late SectionItem sectionItem1;
  late SectionItem sectionItem2;
  late SectionItem sectionItem3;

  late IconGalleryStyle style;

  @override
  void initState() {
    searchBarController = TextEditingController();

    iconList1 = const [
      IconDataItem(value: Icons.ac_unit, name: 'Ac Unit'),
      IconDataItem(value: Icons.access_alarm, name: 'Access Alarm'),
      IconDataItem(value: Icons.access_alarms, name: 'Access Alarms'),
      IconDataItem(value: Icons.access_time, name: 'Access Time'),
      IconDataItem(value: Icons.accessibility, name: 'Accessibility'),
      IconDataItem(value: Icons.accessibility_new, name: 'Accessibility New'),
    ];
    iconList2 = const [
      IconDataItem(value: Icons.accessible, name: 'Accessible'),
      IconDataItem(value: Icons.accessible_forward, name: 'Accessible Forward'),
      IconDataItem(value: Icons.account_balance, name: 'Account Balance'),
      IconDataItem(
          value: Icons.account_balance_wallet, name: 'Account Balance Wallet'),
      IconDataItem(value: Icons.account_box, name: 'Account Box'),
      IconDataItem(value: Icons.account_circle, name: 'Account Circle'),
      IconDataItem(value: Icons.account_tree, name: 'Account Tree'),
      IconDataItem(value: Icons.ad_units, name: 'Ad Units'),
      IconDataItem(value: Icons.adb, name: 'Adb'),
      IconDataItem(value: Icons.add, name: 'Add'),
    ];

    iconList3 = const [
      SvgItem(name: 'calc back', svgPath: 'assets/images/calc_back_icon.svg'),
      SvgItem(name: 'calc back', svgPath: 'assets/images/calendar_icon.svg'),
      SvgItem(name: 'calc back', svgPath: 'assets/images/check_icon.svg'),
      SvgItem(name: 'calc back', svgPath: 'assets/images/circle_icon.svg'),
      SvgItem(name: 'calc back', svgPath: 'assets/images/cross_icon.svg'),
      SvgItem(name: 'calc back', svgPath: 'assets/images/income_type_icon.svg'),
    ];

    sectionItem1 = SectionItem(
      title: 'General',
      items: iconList1,
    );
    sectionItem2 = SectionItem(
      title: 'More',
      items: iconList2,
    );
    sectionItem3 = SectionItem(
      title: 'SVG General',
      items: iconList3,
    );

    style = IconGalleryStyle(
      gridViewMaxCrossAxisExtent: 40,
      itemColor: Colors.black,
      itemSize: 30,
      sectionPadding: const EdgeInsets.symmetric(vertical: 10),
    );

    super.initState();
  }

  @override
  void dispose() {
    searchBarController.dispose();
    super.dispose();
  }

  String selectedIcon = '';
  IconItem? selectedIconValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'selected Item is :$selectedIcon ',
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 400,
              width: MediaQuery.sizeOf(context).width * .5,
              child: IconGallery(
                style: style,
                searchBarController: searchBarController,
                selectedIcon: selectedIconValue,
                sections: [
                  sectionItem1,
                  sectionItem2,
                  sectionItem3,
                ],
                onIconSelected: (icon) {
                  setState(() {
                    selectedIconValue = icon;
                    debugPrint('selected icon is $icon');
                    selectedIcon = selectedIconValue!.name;
                  });
                },
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Show As Dialog'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Show As BottomSheet'),
            ),
          ],
        ),
      ),
    );
  }
}
