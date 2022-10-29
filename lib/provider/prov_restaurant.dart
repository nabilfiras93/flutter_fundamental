import 'package:flutter/material.dart';
import 'package:restaurantfinal/helper/h_navigation.dart';
import 'package:restaurantfinal/models/m_detailrestaurant.dart';
import 'package:restaurantfinal/models/restaurant.dart';
import 'package:restaurantfinal/pages/mydetailrestaurant_.dart';

import '../services/serv_restaurant.dart';

class RestaurantProvider with ChangeNotifier {
  late final RestaurantService _service;
  bool isLoading = true;
  bool isError = false;
  String errorMessage = "";
  List<Restaurant> restaurants = [];

  RestaurantProvider({required RestaurantService service}) {
    _service = service;
    setRestaurantData();
  }

  void setLoading(bool status) {
    isLoading = status;
    notifyListeners();
  }

  void setErrorStatus(bool status) {
    isError = status;
    notifyListeners();
  }

  void setRestaurantData() async {
    setLoading(true);
    try {
      restaurants = await _service.getRestaurants();
      setErrorStatus(false);
    } catch (error) {
      errorMessage = error.toString();
      setErrorStatus(true);
    }
    setLoading(false);
  }

  void searchRestaurant(String text) async {
    if (text.isEmpty) {
      setRestaurantData();
    } else {
      setLoading(true);
      try {
        restaurants = await _service.searchRestaurants(text);
        setErrorStatus(false);
      } catch (error) {
        errorMessage = error.toString();
        setErrorStatus(true);
      }
      setLoading(false);
    }
  }

  void onTapRestaurant(BuildContext context, int index) async {
    try {
      DetailRestaurant restaurant =
          await _service.getRestaurant(restaurants[index].id);

      NavigatorHelper.intentWithData(
          DetailRestaurantPage.routeName, restaurant);
    } catch (error) {
      errorMessage = error.toString();
      setErrorStatus(true);
    }
  }
}
