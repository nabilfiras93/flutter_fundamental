import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurantfinal/models/m_detailrestaurant.dart';
import 'package:restaurantfinal/models/m_reviewrestaurantt.dart';

class ReviewService {
  late final http.Client client;
  static const _apiBaseUrl = 'https://restaurant-api.dicoding.dev';

  ReviewService({required this.client});

  Future<List<RestaurantReview>> addReview(
      String restaurantId, String name, String review) async {
    var res = await client.post(Uri.parse('$_apiBaseUrl/review'),
        body: {'id': restaurantId, 'name': name, 'review': review});

    var jsonResult = jsonDecode(res.body);

    List<RestaurantReview> reviews = [];
    if (!jsonResult['error']) {
      var list = jsonResult['customerReviews'] as List;
      reviews = list.map((val) => RestaurantReview.fromJson(val)).toList();
    }

    return reviews;
  }

  Future<List<RestaurantReview>> getReviews(String restaurantId) async {
    try {
      var res =
          await client.get(Uri.parse('$_apiBaseUrl/detail/$restaurantId'));

      var jsonResult = jsonDecode(res.body);

      DetailRestaurant restaurant =
          DetailRestaurant.fromJson(jsonResult['restaurant']);

      List<RestaurantReview> reviews = restaurant.reviews!;

      if (reviews.isEmpty) {
        throw "isEmpty";
      }
      return reviews;
    } catch (error) {
      print(error);
      if (error == 'isEmpty') {
        throw "Review Masih Belum Ada!";
      }
      throw "Koneksi Internet Tidak Tersedia, Silahkan Refresh Kembali!";
    }
  }
}
