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
  late List<IconDataIconValue> iconList1;
  late List<IconDataIconValue> iconList2;
  late List<SvgIconValue> iconList3;

  late SectionItem sectionItem1;
  late SectionItem sectionItem2;
  late SectionItem sectionItem3;

  @override
  void initState() {
    iconList1 = [
      IconDataIconValue(iconData: Icons.ac_unit, name: 'Ac Unit'),
      IconDataIconValue(iconData: Icons.access_alarm, name: 'Access Alarm'),
      IconDataIconValue(iconData: Icons.access_alarms, name: 'Access Alarms'),
      IconDataIconValue(iconData: Icons.access_time, name: 'Access Time'),
      IconDataIconValue(iconData: Icons.accessibility, name: 'Accessibility'),
      IconDataIconValue(
          iconData: Icons.accessibility_new, name: 'Accessibility New'),
    ];
    iconList2 = [
      IconDataIconValue(iconData: Icons.accessible, name: 'Accessible'),
      IconDataIconValue(
          iconData: Icons.accessible_forward, name: 'Accessible Forward'),
      IconDataIconValue(
          iconData: Icons.account_balance, name: 'Account Balance'),
      IconDataIconValue(
          iconData: Icons.account_balance_wallet,
          name: 'Account Balance Wallet'),
      IconDataIconValue(iconData: Icons.account_box, name: 'Account Box'),
      IconDataIconValue(iconData: Icons.account_circle, name: 'Account Circle'),
      IconDataIconValue(iconData: Icons.account_tree, name: 'Account Tree'),
      IconDataIconValue(iconData: Icons.ad_units, name: 'Ad Units'),
      IconDataIconValue(iconData: Icons.adb, name: 'Adb'),
      IconDataIconValue(iconData: Icons.add, name: 'Add'),
    ];

    iconList3 = [
      SvgIconValue(
          name: 'calc back', svgPath: 'assets/images/calc_back_icon.svg'),
      SvgIconValue(
          name: 'calc back', svgPath: 'assets/images/calendar_icon.svg'),
      SvgIconValue(name: 'calc back', svgPath: 'assets/images/check_icon.svg'),
      SvgIconValue(name: 'calc back', svgPath: 'assets/images/circle_icon.svg'),
      SvgIconValue(name: 'calc back', svgPath: 'assets/images/cross_icon.svg'),
      SvgIconValue(
          name: 'calc back', svgPath: 'assets/images/income_type_icon.svg'),
    ];

    sectionItem1 = SectionItem(
      title: 'General',
      icons: iconList1,
    );
    sectionItem2 = SectionItem(
      title: 'More',
      icons: iconList2,
    );
    sectionItem3 = SectionItem(
      title: 'SVG General',
      icons: iconList3,
    );

    super.initState();
  }

  String selectedIcon = '';
  IconValue? selectedIconValue;
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
