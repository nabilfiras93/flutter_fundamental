import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurantfinal/config/colors.dart';
import 'package:restaurantfinal/config/providers.dart';
import 'package:restaurantfinal/config/routes.dart';
import 'package:restaurantfinal/config/text_theme.dart';
import 'package:restaurantfinal/pages/mydetailrestaurant_.dart';
import 'package:restaurantfinal/pages/mysplash_.dart';
import 'package:restaurantfinal/services/serv_notification.dart';
import 'package:restaurantfinal/services/serv_schedule.dart';
import 'package:restaurantfinal/widgets/myplatformwidget.dart';
import 'helper/h_navigation.dart';

final FlutterLocalNotificationsPlugin notificationsPluginPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationService _notificationService = NotificationService();
  final ScheduleService _reminderService = ScheduleService();

  _reminderService.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await _notificationService.initNotifications(notificationsPluginPlugin);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NotificationService _notificationService = NotificationService();

  Widget _buildAndroid(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Restaurant App',
      theme: ThemeData(
          primaryColor: primaryColor,
          appBarTheme: AppBarTheme(
              elevation: 0,
              color: primaryColor,
              titleTextStyle: Theme.of(context).textTheme.headline6?.copyWith(
                    color: textWhiteColor,
                  )),
          textTheme: textTheme),
      initialRoute: SplashScreen.routeName,
      routes: routes(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(primaryColor: primaryColor),
      initialRoute: SplashScreen.routeName,
      routes: routes(context),
    );
  }

  @override
  void initState() {
    super.initState();
    _notificationService
        .configureSelectNotificationSubject(DetailRestaurantPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: providers,
        child: PlatformWidget(
          iosBuilder: _buildIos,
          androidBuilder: _buildAndroid,
        ));
  }
}
