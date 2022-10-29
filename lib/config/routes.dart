import 'package:flutter/cupertino.dart';
import 'package:restaurantfinal/models/m_detailrestaurant.dart';
import 'package:restaurantfinal/pages/mydetailrestaurant_.dart';
import 'package:restaurantfinal/pages/myfavoriterestaurant_.dart';
import 'package:restaurantfinal/pages/myrestaurant_.dart';
import 'package:restaurantfinal/pages/myrestaurantreview_.dart';
import 'package:restaurantfinal/pages/mysetting_.dart';
import 'package:restaurantfinal/pages/mysplash_.dart';

Map<String, WidgetBuilder> routes(BuildContext context) => {
      SplashScreen.routeName: (context) => const SplashScreen(),
      RestaurantPage.routeName: (context) => const RestaurantPage(),
      RestaurantFavoritePage.routeName: (context) =>
          const RestaurantFavoritePage(),
      SettingPage.routeName: (context) => const SettingPage(),
      DetailRestaurantPage.routeName: (context) => DetailRestaurantPage(
          restaurant:
              ModalRoute.of(context)?.settings.arguments as DetailRestaurant),
      RestaurantReviewPage.routeName: (context) => RestaurantReviewPage(
          restaurantId: (ModalRoute.of(context)?.settings.arguments as List)[0],
          restaurantName:
              (ModalRoute.of(context)?.settings.arguments as List)[1])
    };
