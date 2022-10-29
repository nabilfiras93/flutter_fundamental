import 'package:provider/provider.dart';
import 'package:restaurantfinal/provider/prov_favorite.dart';
import 'package:restaurantfinal/provider/prov_restaurant.dart';
import 'package:restaurantfinal/provider/prov_review.dart';
import 'package:http/http.dart' as http;
import 'package:restaurantfinal/provider/prov_schedule.dart';
import 'package:restaurantfinal/services/serv_favorite.dart';
import 'package:restaurantfinal/services/serv_restaurant.dart';
import 'package:provider/single_child_widget.dart';
import 'package:restaurantfinal/services/serv_review.dart';
import 'package:restaurantfinal/services/serv_setting.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<ReviewProvider>(
      create: (context) => ReviewProvider(
              service: ReviewService(
            client: http.Client(),
          ))),
  ChangeNotifierProvider<RestaurantProvider>(
      create: (context) => RestaurantProvider(
          service: RestaurantService(client: http.Client()))),
  ChangeNotifierProvider<FavoriteProvider>(
      create: (context) => FavoriteProvider(service: FavoriteService())),
  ChangeNotifierProvider<SchedulingProvider>(
      create: (context) => SchedulingProvider(settingService: SettingService()))
];
