import 'package:flutter/material.dart';
import 'package:icon_gallery/icon_gallery.dart';
import 'package:icon_gallery/models/icon_value.dart';

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
  late List<IconValue<IconData>> iconDataList;
  @override
  void initState() {
    iconDataList = [
      IconValue(Icons.ac_unit, 'Ac Unit'),
      IconValue(Icons.access_alarm, 'Access Alarm'),
      IconValue(Icons.access_alarms, 'Access Alarms'),
      IconValue(Icons.access_time, 'Access Time'),
      IconValue(Icons.accessibility, 'Accessibility'),
      IconValue(Icons.accessibility_new, 'Accessibility New'),
      IconValue(Icons.accessible, 'Accessible'),
      IconValue(Icons.accessible_forward, 'Accessible Forward'),
      IconValue(Icons.account_balance, 'Account Balance'),
      IconValue(Icons.account_balance_wallet, 'Account Balance Wallet'),
      IconValue(Icons.account_box, 'Account Box'),
      IconValue(Icons.account_circle, 'Account Circle'),
      IconValue(Icons.account_tree, 'Account Tree'),
      IconValue(Icons.ad_units, 'Ad Units'),
      IconValue(Icons.adb, 'Adb'),
      IconValue(Icons.add, 'Add'),
    ];
    super.initState();
  }

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
            const Text(
              'This is the widget we are testing',
            ),
            SizedBox(height: 300, child: ImageGallery.iconData(iconDataList)),
            TextButton(
              onPressed: () {
                ImageGallery.iconData(iconDataList).showAsDialog(context);
              },
              child: const Text("show as dialog"),
            ),
            TextButton(
              onPressed: () {
                ImageGallery.iconData(iconDataList).showAsBottomSheet(context);
              },
              child: const Text("show as bottom sheet"),
            )
          ],
        ),
      ),
    );
  }
}
