

import 'package:awesome/screens/navigation_cliked_page/navigation_clicked_page.dart';
import 'package:awesome/screens/show_notification_page/show_notification_page.dart';
import 'package:awesome/utils/local_storage.dart';
import 'package:awesome/utils/notification_setup_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await LocalStorage().init();
  await NotificationSetupController.initializeAwesomeNotification();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  //Used For Navigation when Popup Notification is Pressed.
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    // Only after at least the action method is set, the notification events are delivered
    NotificationSetupController.setListener();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: MyApp.navigatorKey,
      title: 'Awesome Notification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: ShowNotificationPage.route,
      routes: {
        ShowNotificationPage.route:(context)=>const ShowNotificationPage(),
        NotificationClickedPage.route:(context)=>const NotificationClickedPage(),
      },
    );
  }
}