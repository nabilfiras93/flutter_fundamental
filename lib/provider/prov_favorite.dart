import 'package:flutter/material.dart';
import 'package:restaurantfinal/models/restaurant.dart';
import 'package:restaurantfinal/services/serv_favorite.dart';

class FavoriteProvider with ChangeNotifier {
  List<Restaurant> _restaurants = [];
  late final FavoriteService _service;

  List<Restaurant> get restaurants => _restaurants;

  FavoriteProvider({required FavoriteService service}) {
    _service = service;
    _getAllRestaurants();
  }

  void _getAllRestaurants() async {
    _restaurants = await _service.getRestaurants();
    notifyListeners();
  }

  Future<void> addRestaurant(Restaurant restaurant) async {
    await _service.addToFavorite(restaurant);
    _getAllRestaurants();
  }

  Future<Restaurant> getRestaurantById(String id) async {
    return await _service.getRestaurantById(id);
  }

  void deleteRestaurant(String id) async {
    await _service.deleteFavoriteRestaurant(id);
    _getAllRestaurants();
  }
}
