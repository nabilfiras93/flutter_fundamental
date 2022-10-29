import 'dart:isolate';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:restaurantfinal/main.dart';
import 'package:restaurantfinal/models/m_detailrestaurant.dart';
import 'package:restaurantfinal/models/restaurant.dart';
import 'package:restaurantfinal/services/serv_notification.dart';
import 'package:restaurantfinal/services/serv_restaurant.dart';

final ReceivePort port = ReceivePort();

class ScheduleService {
  static ScheduleService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  ScheduleService._internal() {
    _instance = this;
  }

  factory ScheduleService() => _instance ?? ScheduleService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    final NotificationService notificationService = NotificationService();
    List<Restaurant> res =
        await RestaurantService(client: http.Client()).getRestaurants();

    Restaurant randomRestaurant = (res..shuffle()).first;

    DetailRestaurant restaurant = await RestaurantService(client: http.Client())
        .getRestaurant(randomRestaurant.id);

    await notificationService.showNotification(
        notificationsPluginPlugin, restaurant);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
