import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_be_done/app/core/theme/theme.dart';

import 'package:to_be_done/app/data/services/services.dart';
import 'package:to_be_done/app/modules/modules.dart';
import 'package:to_be_done/app/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await AndroidAlarmManager.initialize();

  // Initialize Services
  await initServices();

  // Injecting dependencies
  await initControllers();

  runApp(const MyApp());
}

Future<void> initPlugins() async {
  await Future.wait([
    AndroidAlarmManager.initialize(),
  ]);
}

// class MyDemoApp extends StatelessWidget {
//   const MyDemoApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'To Be Done',
//       theme: ThemeData(
//         primaryColor: Colors.teal,
//         textTheme: GoogleFonts.poppinsTextTheme(),
//       ),
//       home: IndexPage(),
//       locale: Get.locale,
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'To Be Done',
      theme: lightTheme,
      locale: Get.locale,
      initialRoute: Pages.INITIAL,
      getPages: Pages.routes,
    );
  }
}
