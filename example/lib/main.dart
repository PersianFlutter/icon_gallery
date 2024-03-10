import 'package:flutter/material.dart';
import 'package:icon_gallery/icon_gallery.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<IconDataItem> iconList1;
  late List<IconDataItem> iconList2;
  late List<SvgItem> iconList3;

  late SectionItem sectionItem1;
  late SectionItem sectionItem2;
  late SectionItem sectionItem3;

  @override
  void initState() {
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

    super.initState();
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
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'selected Item is :$selectedIcon ',
            ),
            SizedBox(
              height: 400,
              child: IconPickerWidget(
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
                  }),
            ),
            TextButton(onPressed: () {}, child: const Text('Show As Dialog')),
            TextButton(
                onPressed: () {}, child: const Text('Show As BottomSheet')),
          ],
        ),
      ),
    );
  }
}
