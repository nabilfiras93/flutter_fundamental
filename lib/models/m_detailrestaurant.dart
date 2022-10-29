import 'package:restaurantfinal/models/restaurant.dart';
import 'package:restaurantfinal/models/m_reviewrestaurantt.dart';

class DetailRestaurant {
  late final Restaurant restaurant;
  bool? _isFavorite;
  late final List<String> categories;
  late final List<String> foods;
  late final List<String> drinks;
  List<RestaurantReview>? reviews;

  DetailRestaurant(
      {required this.restaurant,
      required this.categories,
      required this.foods,
      required this.drinks,
      required this.reviews});

  DetailRestaurant.fromJson(Map<String, dynamic> json) {
    restaurant = Restaurant.fromJson(json);

    var listCategories = json['categories'] as List;
    categories =
        listCategories.map<String>((val) => val['name'].toString()).toList();

    var listFoods = json['menus']['foods'] as List;
    foods = listFoods.map<String>((val) => val['name'].toString()).toList();

    var listDrinks = json['menus']['drinks'] as List;
    drinks = listDrinks.map<String>((val) => val['name'].toString()).toList();

    var listReview = json['customerReviews'] as List;
    reviews = listReview
        .map<RestaurantReview>((val) => RestaurantReview.fromJson(val))
        .toList();
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonRestaurant = restaurant.toJson();

    jsonRestaurant['categories'] =
        categories.map((category) => {'name': category}).toList();

    jsonRestaurant['menus'] = {
      'foods': foods
          .map((food) => {
                'name': food,
              })
          .toList(),
      'drinks': drinks
          .map((drink) => {
                'name': drink,
              })
          .toList()
    };

    jsonRestaurant['customerReviews'] =
        reviews?.map((review) => review.toJson()).toList();

    return jsonRestaurant;
  }

  bool get isFavorite => _isFavorite ?? false;
  set isFavorite(bool status) {
    _isFavorite = status;
  }
}
