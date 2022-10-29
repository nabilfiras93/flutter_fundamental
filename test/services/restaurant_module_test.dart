import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:restaurantfinal/models/m_detailrestaurant.dart';
import 'package:restaurantfinal/models/restaurant.dart';
import 'package:restaurantfinal/services/serv_restaurant.dart';
import 'restaurant_module_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test('returns restaurant if the http call complete successfully', () async {
    final client = MockClient();
    when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
        .thenAnswer((realInvocation) async => http.Response('''
        {
          "error": false,
          "message": "success",
          "restaurants": [
            {
              "id": "1", "name": "mock", "description": "mock", 
              "pictureId": "1", "city": "mock", "rating": 5.0
            },
            {
              "id": "2", "name": "mock", "description": "mock", 
              "pictureId": "2", "city": "mock", "rating": 5.0
            }
          ]
        }
      ''', 200));

    var restaurants = await RestaurantService(client: client).getRestaurants();
    expect(restaurants.runtimeType, List<Restaurant>);
  });

  test('return detail restaurant if the http call complete successfully',
      () async {
    final client = MockClient();
    when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/detail/1')))
        .thenAnswer((realInvocation) async => http.Response('''
        {
          "error": false,
          "message": "success",
          "restaurant": {
              "id": "1",
              "name": "mock",
              "description": "mock",
              "city": "mock",
              "address": "mock",
              "pictureId": "1",
              "categories": [ { "name": "mock 1" }, { "name": "mock 2" } ],
              "menus": {
                  "foods": [ { "name": "Mock 1" }, { "name": "Mock 2" } ],
                  "drinks": [ { "name": "Mock 2" }, { "name": "Mock 2" } ]
              },
              "rating": 5.0,
              "customerReviews": [
                { "name": "Mock", "review": "Mock", "date": "Mock" }
              ]
          }
      }
      ''', 200));

    var restaurant = await RestaurantService(client: client).getRestaurant("1");
    expect(restaurant.runtimeType, DetailRestaurant);
  });
}
