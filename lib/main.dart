import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jparser/page/home_page.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setSize(const Size(800, 600));
    await windowManager.setMinimumSize(const Size(800, 600));
    await windowManager.center();
    windowManager.show();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'JParser',
      home: MyHomePage(),
    );
  }
}
