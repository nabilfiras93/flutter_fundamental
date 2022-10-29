import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurantfinal/helper/h_navigation.dart';
import 'package:restaurantfinal/models/m_detailrestaurant.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationService {
  static NotificationService? _instance;

  NotificationService._internal() {
    _instance = this;
  }

  factory NotificationService() => _instance ?? NotificationService._internal();

  Future<void> initNotifications(FlutterLocalNotificationsPlugin plugin) async {
    var initializationSettingAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingIos = const IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false);

    var initializationSettings = InitializationSettings(
      android: initializationSettingAndroid,
      iOS: initializationSettingIos,
    );

    await plugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(FlutterLocalNotificationsPlugin plugin,
      DetailRestaurant restaurant) async {
    var _channelId = "1";
    var _channelName = "channel_$_channelId";
    var _channelDescription = 'daily restaurant channel';

    var iosPlatformChannelSpecifics = const IOSNotificationDetails();
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName,
        channelDescription: _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );

    await plugin.show(0, restaurant.restaurant.name,
        "rekomendasi restoran untukmu!", platformChannelSpecifics,
        payload: jsonEncode(restaurant.toJson()));
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen((String payload) async {
      var restaurant = DetailRestaurant.fromJson(jsonDecode(payload));
      NavigatorHelper.intentWithData(route, restaurant);
    });
  }
}
